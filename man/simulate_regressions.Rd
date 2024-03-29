% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/small_sim_study.R
\name{simulate_regressions}
\alias{simulate_regressions}
\title{Simulate regressions under different conditions}
\usage{
simulate_regressions(
  type,
  n_folds = c(3, 5, 10),
  n_obs = c(100, 500, 1000),
  p = 10,
  rho = 0.5,
  mu = c(1, 5),
  stddev = c(0.2, 20),
  spars = 0.5,
  betas = c(0.01, 0.2),
  sigma = NULL,
  skew = NULL
)
}
\arguments{
\item{type}{linear or logistic}

\item{n_folds}{vector of number of folds to vary}

\item{n_obs}{vector of number of observations to vary}

\item{p}{number of predictors}

\item{rho}{correlation of predictors for MVN}

\item{mu}{means of predictors for MVN}

\item{stddev}{standard deviation of predictors for MVN}

\item{spars}{sparsity of predictors as a proportion}

\item{betas}{true coefficients}

\item{sigma}{standard deviation of residuals for linear models}

\item{skew}{distribution of covariate matrix}
}
\value{
tidy dataframe of mean number of non-zero coefficients and associated errors
}
\description{
Simulate regressions under different conditions
}
\examples{
study_data_no_skew <- simulate_regressions(type = "linear", sigma=1)
study_data_exp <- simulate_regressions(type = "linear", sigma = 1, skew = "exponential")
study_data_beta <- simulate_regressions(type = "linear", sigma = 1, skew = "beta")
combined <- dplyr::bind_rows(study_data_beta, study_data_exp, study_data_no_skew)
combined \%>\%
dplyr::mutate(skew = dplyr::case_when(is.na(skew) ~ "normal",
skew == "exponential" ~ "exponential", skew == "beta" ~ "beta")) \%>\%
dplyr::group_by(model, skew) \%>\% dplyr::summarise(mean_rmse = mean(avgError),
mean_params = mean(params))
}
