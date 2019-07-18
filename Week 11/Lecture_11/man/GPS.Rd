\name{GPS}
\alias{GPS}
\alias{GPS_elev}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Constructor functions
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
GPS(latitude, longitude, datum)

GPS_elev(latitude, longitude, datum, elevation)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{latitude}{
%%     ~~Describe \code{latitude} here~~
}
  \item{longitude}{
%%     ~~Describe \code{longitude} here~~
}
  \item{datum}{
%%     ~~Describe \code{datum} here~~
}
\item{elevation}{
A vector of elevations
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
mygps <- GPS_elev(50, 100, "WGS84", 20)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
