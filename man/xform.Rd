% Generated by roxygen2 (4.1.0): do not edit by hand
% Please edit documentation in R/xform.R
\name{xform}
\alias{xform}
\alias{xform.character}
\alias{xform.default}
\alias{xform.dotprops}
\alias{xform.list}
\alias{xform.neuronlist}
\title{Transform the 3d location of objects such as neurons}
\usage{
xform(x, reg, ...)

\method{xform}{default}(x, reg, na.action = c("warn", "none", "drop",
  "error"), ...)

\method{xform}{character}(x, reg, ...)

\method{xform}{list}(x, reg, FallBackToAffine = TRUE, na.action = "error",
  ...)

\method{xform}{dotprops}(x, reg, FallBackToAffine = TRUE, ...)

\method{xform}{neuronlist}(x, reg, subset = NULL, ..., OmitFailures = NA,
  VectoriseRegistrations = FALSE)
}
\arguments{
  \item{x}{an object to transform}

  \item{reg}{an object describing a transformation in any
  of the forms understood by \code{\link{xformpoints}} (see
  details).}

  \item{...}{additional arguments passed to methods and
  eventually to \code{\link{xformpoints}}}

  \item{na.action}{How to handle NAs. NB drop may not work
  for some classes.}

  \item{FallBackToAffine}{Whether to use an affine
  transform when a cmtk warping transformation fails.}

  \item{subset}{For \code{xform.neuronlist} indices
  (character/logical/integer) that specify a subset of the
  members of \code{x} to be transformed.}

  \item{OmitFailures}{Whether to omit neurons for which
  \code{FUN} gives an error. The default value (\code{NA})
  will result in nlapply stopping with an error message the
  moment there is an eror. For other values, see details.}

  \item{VectoriseRegistrations}{When \code{FALSE}, the
  default, each element of \code{reg} will be applied
  sequentially to each element of \code{x}. When
  \code{TRUE}, it is assumed that there is one element of
  \code{reg} for each element of \code{x}.}
}
\description{
\code{xform} is designed to operate on a variety of data
types, especially objects encapsulating neurons.

\code{xform.character} is designed to work with files on
disk.  Presently it is restricted to images, although other
datatypes may be supported in future.
}
\details{
Methods are provided for some specialised S3 classes.
Further methods can of course be constructed for
user-defined S3 classes. However this will probalbly not be
necessary if the \code{xyzmatrix} and \code{`xyzmatrix<-`}
generics are suitably overloaded \emph{and} the S3 object
inherits from \code{list}.

Where reg is a function, it should have a signature like
\code{myfun(x, ...)} where the ... \strong{must} be
provided in order to swallow any arguments passed from
higher level functions that are not relevant to this
particular transformation function.

TODO get this to work for matrices with more than 3 columns
by working on xyzmatrix definition.

the dotprops tangent vectors will be recalculated after the
points have been transformed (even though they could in
theory be transformed more or less correctly).

With \code{xform.neuronlist}, if you want to apply a
different registration to each object in the neuronlist
\code{x}, then you should use
\code{VectoriseRegistrations=TRUE}.
}
\examples{
\dontrun{
kc1=kcs20[[1]]
kc1.default=xform(kc1,function(x,...) x)
stopifnot(isTRUE(all.equal(kc1,kc1.default)))
kc1.5=xform(kc1,function(x,...) x, k=5)
stopifnot(isTRUE(all.equal(kc1.5,kc1.default)))
kc1.20=xform(kc1,function(x,...) x, k=20)
stopifnot(!isTRUE(all.equal(kc1,kc1.20)))
}
\dontrun{
# apply reg1 to Cell07PNs[[1]], reg2 to Cell07PNs[[2]] etc
regs=c(reg1, reg2, reg3)
nx=xform(Cell07PNs[1:3], reg=regs, VectoriseRegistrations=TRUE)
}
}
\seealso{
\code{\link{xformpoints}}
}

