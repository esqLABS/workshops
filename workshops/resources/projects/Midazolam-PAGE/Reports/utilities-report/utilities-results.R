#' Create results for specified scenarios
#'
#' @param projectConfiguration The `ProjectConfiguration` used to create the project.
#' @param params Execution parameters as defined in the report header.
#' @param scenarioNames Names of scenarios to execute
#' @param dataSheets Names of data sheets to load
#' @param plotGridNames Names of plots to generate
#' @param simulationRunOptions Object of type SimulationRunOptions that will be passed to simulation runs. If NULL, default options are used.
#' Can be used to, e.g., disable check for negative values.
#' @param stopIfParameterNotFound If `TRUE`, the execution will be terminated if
#' any parameter specified is not found in the simulation. The value `FALSE` should
#' be used with caution, as if a parameter defined for the scenario is not found in the
#' simulation is often a sign of a problem in scenario definition.
#' @param customParams A list containing vectors 'paths' with the full paths to the parameters,
#' 'values' the values of the parameters, and 'units' with the units
#' the values are in. The values to be applied to the model.
#' @param customDataSets A named list of `DataSet` objects that can be used to
#' create figures. These data sets will be used additionally (or instead) of data
#' loaded from excel sheets defined in `dataSheets`. The names of the list are
#' the names of the data sets. If `customDataSet` contains a data set with the same
#' name as a data set created by reading from the excel sheet, the data set will
#'  be used instead of the one from excel.
#' @param saveResultsFolder Sub-folder where the results will be stored.
#'
#' @returns A named list with `scenarioResults` being the outputs of `simulateScenarios()` function,
#' `observedData` being the loaded observed data, `dataCombined` the `DataCombined` objects used to generate plots,
#' and `plots` being the created plots.
createResults <- function(
  projectConfiguration,
  params = list("loadPreSimulatedResults" = FALSE),
  scenarioNames = NULL,
  customParams = NULL,
  dataSheets = list(),
  customDataSets = NULL,
  plotGridNames = NULL,
  simulationRunOptions = NULL,
  stopIfParameterNotFound = TRUE,
  saveResultsFolder = NULL
) {
  # Simulate the specified scenarios
  scenarioResults <- simulateScenarios(
    projectConfiguration = projectConfiguration,
    scenarioNames = scenarioNames,
    customParams = customParams,
    simulationRunOptions = simulationRunOptions,
    stopIfParameterNotFound = stopIfParameterNotFound,
    loadPreSimulatedResults = params$loadPreSimulatedResults,
    loadResultsFolder = params$loadResultsFolder,
    saveResultsFolder = saveResultsFolder
  )

  observedData <- NULL
  # Load data from excel. Only if sheets are specified!!!
  if (length(dataSheets) > 0) {
    observedData <- esqlabsR::loadObservedData(
      projectConfiguration = projectConfiguration,
      sheets = dataSheets
    )
  }
  # Add custom data sets to the loaded ones
  observedData[names(customDataSets)] <- customDataSets

  allPlots <- NULL
  allDc <- NULL
  # Create plots. Only if plots are specified!!!
  if (length(plotGridNames) > 0) {
    allDc <- esqlabsR::createDataCombinedFromExcel(
      projectConfiguration = projectConfiguration,
      plotGridNames = plotGridNames,
      simulatedScenarios = scenarioResults$simulatedScenarios,
      observedData = observedData
    )

    allPlots <- esqlabsR::createPlotsFromExcel(
      simulatedScenarios = scenarioResults$simulatedScenarios,
      observedData = observedData,
      projectConfiguration = projectConfiguration,
      plotGridNames = plotGridNames,
      dataCombinedList = allDc
    )
  }

  return(list(
    scenarioResults = scenarioResults,
    observedData = observedData,
    dataCombined = allDc,
    plots = allPlots
  ))
}


#' Combine results from two `createResults` outputs
#'
#' @param results1 Output of the function `createResults`. A named list with names 'scenarioResults', 'observedData', 'dataCombined', and 'plots'.
#' @param results2 Output of the function `createResults`. A named list with names 'scenarioResults', 'observedData', 'dataCombined', and 'plots'.
#'
#' @returns A named list with `scenarioResults` being the outputs of `simulateScenarios()` function,
#' `observedData` being the loaded observed data, `dataCombined` the `DataCombined` objects used to generate plots,
#' and `plots` being the created plots. The contents of the two lists are combined, with the second list overwriting the first one in case of conflicts.
combineResults <- function(results1, results2) {
  if (
    isFALSE(all.equal(
      names(results1),
      c("scenarioResults", "observedData", "dataCombined", "plots")
    )) ||
      isFALSE(all.equal(
        names(results2),
        c("scenarioResults", "observedData", "dataCombined", "plots")
      ))
  ) {
    stop(
      "Invalid results structure provided! Expected are named lists with names 'scenarioResults', 'observedData', 'dataCombined', and 'plots'."
    )
  }
  reportResults <- list()
  reportResults$scenarioResults$scenarios <- c(
    results1$scenarioResults$scenarios,
    results2$scenarioResults$scenarios
  )
  reportResults$scenarioResults$simulatedScenarios <- c(
    results1$scenarioResults$simulatedScenarios,
    results2$scenarioResults$simulatedScenarios
  )
  reportResults$observedData <- c(results1$observedData, results2$observedData)
  reportResults$dataCombined <- c(
    results1$dataCombined,
    results2$dataCombined
  )
  reportResults$plots <- c(results1$plots, results2$plots)

  return(reportResults)
}

#' Export plots to files.
#'
#' Uses ospsuite.plots::exportPlot to export the plots.
#'
#' Saves the plots created in the report to PNG (or other format, if specified) files in the same folder as the
#' location of the report plus subfolder "Figures".
#'
#' @param projectConfiguration The `ProjectConfiguration` used to create the project.
#' @param plots A named list with the plots to be exported. The names of the list are used as file names for the exported plots, with "\" and "/" replaced by "_".
#' @inheritDotParams ospsuite.plots::exportPlot
exportPlots <- function(
  projectConfiguration,
  plots,
  ...
) {
  ospsuite.utils::validateIsOfType(projectConfiguration, "ProjectConfiguration")

  # Export plots to png
  # Figures should be saved in the same folder as the location of the report
  # plus subfolder "Figures"
  outputPath <- file.path(projectConfiguration$outputFolder, "Figures")
  # Export each created plot
  for (plotName in names(plots)) {
    plot <- plots[[plotName]]
    # Save plot
    ospsuite.plots::exportPlot(
      plot,
      filepath = outputPath,
      filename = plotName,
      ...
    )
  }
}
