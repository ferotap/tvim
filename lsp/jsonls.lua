return {
  cmd = {'vscode-json-language-server'},
  rootmarkers = {'*.json'},
  filetypes = {'json'},
  settings = {
    json = {
      schemas = require("schemastore").json.schemas(),
      validate = { enable = true },
    },
  },
}
