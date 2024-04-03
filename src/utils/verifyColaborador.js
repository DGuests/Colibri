const connection = require('@src/models')

async function verifyColaborador (user, type) {
  const dbConnection = await connection()
  let colaborador = null
  if (user.documento.length === 11) {
    if (type !== 'cozinha') {
      colaborador = await dbConnection.model('eveColaborador').findAll({
        where: { id_colaborador: user.id },
        attributes: ['id', 'id_evento', 'funcao', 'id_colaborador'],
        include: {
          model: dbConnection.model('EveFuncao'),
          include: { model: dbConnection.model('EveFuncaoAcessos') }
        }
      })

      return colaborador || null
    } else {
      colaborador = await dbConnection.model('usuColaboradorFixo').findAll({
        where: { id_usuario: user.id },
        attributes: ['id_estabelecimento', 'id_funcao'],
        include: {
          model: dbConnection.model('EveFuncao'),
          include: { model: dbConnection.model('EveFuncaoAcessos') }
        }
      })

      return colaborador || null
    }
  } else {
    return null
  }
}

module.exports = verifyColaborador
