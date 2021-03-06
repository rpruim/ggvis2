#' Layer lines on a plot.
#'
#' \code{layer_lines} differs from \code{layer_paths} in that \code{layer_lines}
#' sorts the data on the x variable, so the line will always proceed from left
#' to right, whereas \code{layer_paths} will draw a line in whatever order
#' appears in the data.
#'
#' @seealso \code{\link{layer_paths}}
#' @export
#' @param vis Visualisation to modify.
#' @param ... Visual properties.
#' @examples
#' mtcars2 <- dplyr::mutate(mtcars, cyl = factor(cyl))
#' mtcars2 %>% ggvis(~wt, ~mpg, stroke = ~cyl) %>% layer_lines()
#'
#' # Equivalent to
#' mtcars2 %>% ggvis(~wt, ~mpg, stroke = ~cyl) %>%
#'   group_by(cyl) %>% dplyr::arrange(wt) %>% layer_paths()
layer_lines <- function(vis, ...) {

  x_var <- vis$cur_props$x$value

  layer_f(vis, function(x) {
    x <- auto_group(x, exclude = c("x", "y"))
    x <- do_call(dplyr::arrange, quote(x), x_var)
    emit_paths(x, props(...))
  })
}
