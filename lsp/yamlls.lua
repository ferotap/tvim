return {
  cmd = {'yaml-language-server'},
  filetypes = {'yaml', 'yml'},
  rootmarkers = {'.git'},
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = "",
      },
      schemas = require("schemastore").yaml.schemas(),
    },
  },

}
