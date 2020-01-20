if (require("testthat") &&
  require("parameters") &&
  require("lme4")) {
  data("mtcars")
  mtcars$cyl <- as.factor(mtcars$cyl)
  model <- lmer(mpg ~ as.factor(gear) * hp + as.factor(am) + wt + (1 | cyl), data = mtcars)

  mp1 <- model_parameters(model, digits = 5)
  mp2 <- model_parameters(model, digits = 5, df_method = "s")
  mp3 <- model_parameters(model, digits = 5, df_method = "k")

  test_that("model_parameters, df_method wald", {
    expect_equal(mp1$SE, c(2.77457, 3.69574, 3.521, 0.01574, 1.58514, 0.86316, 0.02973, 0.01668), tolerance = 1e-3)
    expect_equal(mp1$df, c(22, 22, 22, 22, 22, 22, 22, 22), tolerance = 1e-3)
    expect_equal(mp1$p, c(0, 0.00068, 0.12872, 0.15695, 0.846, 0.00224, 0.00029, 0.31562), tolerance = 1e-3)
    expect_equal(mp1$CI_low, c(24.86326, 5.31796, -1.5521, -0.05313, -2.79893, -4.33015, -0.16595, -0.04943), tolerance = 1e-3)
  })

  test_that("model_parameters, df_method satterthwaite", {
    expect_equal(mp2$SE, c(2.77457, 3.69574, 3.521, 0.01574, 1.58514, 0.86316, 0.02973, 0.01668), tolerance = 1e-3)
    expect_equal(mp2$df, c(24, 24, 24, 24, 24, 24, 24, 24), tolerance = 1e-3)
    expect_equal(mp2$p, c(0, 0.00236, 0.14179, 0.16979, 0.84763, 0.00542, 0.00136, 0.32563), tolerance = 1e-3)
    expect_equal(mp2$CI_low, c(24.86326, 5.31796, -1.5521, -0.05313, -2.79893, -4.33015, -0.16595, -0.04943), tolerance = 1e-3)
  })

  test_that("model_parameters, df_method kenward", {
    expect_equal(mp3$SE, c(2.97608, 6.10454, 3.98754, 0.02032, 1.60327, 0.91599, 0.05509, 0.01962), tolerance = 1e-3)
    expect_equal(mp3$df, c(19.39553, 23.57086, 22.7421, 2.72622, 5.27602, 22.82714, 8.97297, 23.76299), tolerance = 1e-3)
    expect_equal(mp3$p, c(0, 0.01772, 0.14202, 0.1907, 0.84772, 0.00546, 0.04232, 0.32614), tolerance = 1e-3)
    expect_equal(mp3$CI_low, c(24.46832, 0.5968, -2.46649, -0.06211, -2.83447, -4.4337, -0.21565, -0.0552), tolerance = 1e-3)
  })
}