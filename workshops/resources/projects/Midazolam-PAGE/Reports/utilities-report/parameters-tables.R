#' Create a table listing the values of parameters of scenarios.
#'
#' @param paths A vector of simulation paths to the parameters.
#' @param aliases A vector of aliases for the parameters. The parameters will be listed
#' in the table with their aliases. Must have the same lengths as `paths`.
#' @param units A vector of units for the parameters. The parameters will be listed
#' in the table in these units. Must have the same lengths as `paths`.
#' @param reportResults Output of the function `createResults()`. A named list
#' with the entries `scenarioResults`, `observedData`, and `plots`.
#' @param scenarios The name of the scenario or a list of names to extract the parameter values from.
#' For each scenario, a separate column will be created.
#'
#' @returns A `tibble` with the columns `Parameter` listing parameter aliases,
#' `<Scenario Name>'  value of the parameter in the respective scenario, and `Unit`.
getParameterValuesAsTable <- function(
  reportResults,
  scenarios,
  aliases,
  paths,
  units
) {
  paramsTable <- tibble::tibble(
    "Parameter" = aliases
  )
  for (scenario in scenarios) {
    simulation <- reportResults$scenarioResults$scenarios[[
      scenario
    ]]$simulation
    paramsTable[[scenario]] <- ospsuite::getQuantityValuesByPath(
      paths,
      units = units,
      simulation = simulation
    )
  }

  paramsTable[["Unit"]] <- units

  return(paramsTable)
}

#' Summarize model performance as a table of predicted vs observed values.
#'
#' @param reportResults Output of the function `createResults()`. A named list
#' with the entry `dataCombined` containing observed and simulated data.
#' @param dataCombinedNames The names of `DataCombined` to calculate the metrics for
#' For each DataCombined, a separate column will be created. DataCombined are used to define the plots.
#'
#' The DataCombined must be present in the `reportResults$dataCombined` list. They are usually automatically
#' created when specifying the figures to create.
#'
#' @returns A tibble summarizing the percentage of points within 2-fold, 5-fold, and 10-fold
#' error for each group and combined.
#'
#' @export
#' @examples
#' summary <- getModelPerformanceAsTable(reportResults, list("DC1", "DC2"))
getModelPerformanceAsTable <- function(reportResults, dataCombinedNames) {
  # Calculate predicted-vs-observed from the data combined
  outputTable <- tibble::tibble()
  for (dcName in dataCombinedNames) {
    dc <- reportResults$dataCombined[[dcName]]
    predVsObs <- ospsuite::calculateResiduals(dc, scaling = "log")

    # add a column with fold changes
    predVsObs$foldChange <- predVsObs$yValuesSimulated /
      predVsObs$yValuesObserved

    # Create a summary with % of points within 2-fold, 5-fold, and 10-fold for each group separately and combined
    summaryTable <- predVsObs %>%
      group_by(group) %>%
      summarise(
        totalPoints = n(),
        within2Fold = sum(foldChange <= 2 & foldChange >= 0.5),
        within5Fold = sum(foldChange <= 5 & foldChange >= 0.2),
        within10Fold = sum(foldChange <= 10 & foldChange >= 0.1),
        totalError = sum(abs(residualValues))
      ) %>%
      mutate(
        percentWithin2Fold = (within2Fold / totalPoints) * 100,
        percentWithin5Fold = (within5Fold / totalPoints) * 100,
        percentWithin10Fold = (within10Fold / totalPoints) * 100
      )
    # Add the scenario column
    summaryTable <- summaryTable %>%
      mutate(scenario = dcName) %>%
      select(scenario, everything())

    # Combine with the output table
    outputTable <- bind_rows(outputTable, summaryTable)
  }

  # Add a combined summary row
  combinedSummary <- outputTable %>%
    summarise(
      totalPoints = sum(totalPoints),
      within2Fold = sum(within2Fold),
      within5Fold = sum(within5Fold),
      within10Fold = sum(within10Fold),
      totalError = sum(totalError)
    ) %>%
    mutate(
      percentWithin2Fold = (within2Fold / totalPoints) * 100,
      percentWithin5Fold = (within5Fold / totalPoints) * 100,
      percentWithin10Fold = (within10Fold / totalPoints) * 100,
      scenario = "Combined"
    )
  outputTable <- bind_rows(outputTable, combinedSummary)
  # Place the "totalError" column at the end
  outputTable <- outputTable %>%
    select(
      scenario,
      group,
      totalPoints,
      within2Fold,
      within5Fold,
      within10Fold,
      percentWithin2Fold,
      percentWithin5Fold,
      percentWithin10Fold,
      totalError
    )
  # Rename columns

  colnames(outputTable) <- c(
    "Scenario",
    "Group",
    "Total points",
    "Within 2-fold",
    "Within 5-fold",
    "Within 10-fold",
    "% 2-fold",
    "% 5-fold",
    "% 10-fold",
    "Total Error"
  )

  return(outputTable)
}
