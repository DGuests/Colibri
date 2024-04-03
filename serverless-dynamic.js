const fs = require('fs')
const YAML = require('yamljs')

const files = fs.readdirSync('./config/handlers')

module.exports = () => files
  .map(f => fs.readFileSync(`./config/handlers/${f}`, 'utf8'))
  .map(raw => YAML.parse(raw))
  .reduce((result, handler) => Object.assign(result, handler), {})
