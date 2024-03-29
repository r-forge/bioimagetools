\name{distance2border}
\alias{distance2border}
\title{
A function to compute the distance from  }
\description{
Find distances to borders in classified image
}
\usage{
distance2border(points, img.classes, x.microns, y.microns, z.microns, class1, class2 = NULL, mask = array(TRUE, dim(img.classes)), hist = FALSE, main = "Minimal distance to border", xlab = "Distance in Microns", xlim = c(-0.3, 0.3), n = 20, stats = TRUE, file = NULL)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{points}{
Data frame containing the coordinates of points in microns as X-, Y-, and Z-variables.
}
  \item{img.classes}{
3D array (or image) of classes for each voxel.
}
  \item{x.microns}{
Size of image in x-direction in microns.
}
  \item{y.microns}{
Size of image in y-direction in microns.
}
  \item{z.microns}{
Size of image in z-direction in microns.
}
  \item{class1}{
Which class is the reference class. If is.null(class2), the function computes the distance of points to the border of class (in img.classes).
}
  \item{class2}{
Which class is the second reference class. If not is.null(class2), the function computes the distance of points from the border between classes class1 and class2. Default: class2=NULL.
}
  \item{mask}{
Array of mask. Needs to have same dimension as img.classes. Only voxels with mask[i,j,k]==TRUE are used. Default: array(TRUE,dim(img.classes))
}
  \item{hist}{
Automatically plot histogram using hist() function. Default: FALSE.
}
  \item{main}{
If (hist) title of histogramm. Default: "Minimal distance to border".
}
  \item{xlab}{
If (hist) description of x axis. Default: "Distance in Microns".
}
  \item{xlim}{
If (hist) vector of range of x axis (in microns). Default: c(-.3,.3)
}
  \item{n}{
If (hist) number of bins used in hist(). Default: 20.
}
  \item{stats}{
If (hist) write statistics into plot. Default: TRUE.
}
  \item{file}{
If (hist) the file name of the produced png. If NULL, the histogram is plotted to the standard device. Default: NULL.  
}
}
\details{
This function computes the distances from points to the border of a class or the border between two classes. For the latter, only points in these two classes are used.
}
\value{
The function returns a vector with distances. Negative values correspond to points lying in class1. 
}
\author{
Volker Schmid
}
\note{
Warning:
So far no consistency check for arguments is done. E.g., 
distance2border(randompoints,img.classes=array(1,c(100,100,2)),3,3,1,class1=2)
will fail with some cryptic error message (because class1 > max(img.classes)).
}
\examples{
\dontrun{
require(bioimagetools)
#simulate random data
randompoints<-data.frame("X"=runif(100,0,3),"Y"=runif(100,0,3),"Z"=runif(100,0,.5)) # coordinates in microns!
plot(randompoints$X,randompoints$Y,xlim=c(0,3),ylim=c(0,3),pch=19)

# points in a circle
circlepoints<-read.table(system.file("extdata","kreispunkte.table",package="bioimagetools"),header=TRUE)
plot(circlepoints$X,circlepoints$Y,xlim=c(0,3),ylim=c(0,3),pch=19)

# a circle like image
img<-readTIF(system.file("extdata","kringel.tif",package="bioimagetools"))
img<-array(img,dim(img)) # save as array for easier handling
image(img[,,1])

#and a mask
mask<-readTIF(system.file("extdata","amask.tif",package="bioimagetools"))
mask<-array(mask==65536,dim(mask)) # save as array for easier handling
image(mask[,,1])


xy.microns <- 3 # size in x and y direction (microns)
z.microns <- 0.5 # size in z direction (microns)

# distance from points to class 
d1<-distance2border(randompoints, img, xy.microns, xy.microns, z.microns, class1=1,hist=TRUE)
d2<-distance2border(circlepoints, img, xy.microns, xy.microns, z.microns, class1=1,hist=FALSE)
plot(density(d2),type="l")
lines(c(0,0),c(0,10),lty=3)
lines(density(d1),col="blue")

# use mask, should give some small changes
d3<-distance2border(circlepoints, img, xy.microns, xy.microns, z.microns, class1=1,mask=mask,hist=FALSE)
plot(density(d2),type="l")
lines(c(0,0),c(0,10),lty=3)
lines(density(d3),col="blue")

# distance from border between classes
anotherimg<-img+mask
image(seq(0,3,length=300),seq(0,3,length=300),anotherimg[,,1])
points(circlepoints,pch=19)
d4<-distance2border(circlepoints, anotherimg, xy.microns, xy.microns, z.microns, class1=1,class2=2)
plot(density(d4),lwd=2)

# this should give the same answer
d5<-distance2border(circlepoints, anotherimg, xy.microns, xy.microns, z.microns, class1=2,class2=1)
lines(density(-d5),lty=3,col="blue",lwd=1.5)
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
