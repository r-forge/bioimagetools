blackTopHatGreyScale = function (x, kern=makeBrush(5, shape='diamond')) {
  return (.Call("lib_tophat_greyscale", x, kern, as.integer(1), PACKAGE='bioimagetools') )
}