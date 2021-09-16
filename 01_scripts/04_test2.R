library(devtools)
devtools::install_github("quishqa/qualR")

library(qualR)

rj_centro <- MonitorArRetrieveParam(start_date = "01/01/2019",
                                    end_date = "31/12/2019",
                                    aqs_code = "CA",
                                    parameters = "PM10",
                                    to_local = FALSE)

openair::timeVariation(rj_centro, pol = "PM10")
