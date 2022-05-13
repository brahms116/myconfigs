

local gl = require('galaxyline')


gl.section.left[1]={
  GitBranch = {
    provider = 'GitBranch',
    separator = " "
  }
}

gl.section.left[2]={
  FileName = {
    provider = 'FileName',
  }
}
