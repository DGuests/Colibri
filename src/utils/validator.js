const Joi = require('joi')
const { userAttributesPick } = require('@src/utils')
const connection = require('@src/models')

const validationEstablishmentRequest = Joi.object({
  name: Joi.string()
    .min(3)
    .required(),
  type: Joi.array().items(
    Joi.string().required()
  ),
  address: Joi.string()
    .min(3)
    .required(),
  about: Joi.string()
    .min(3)
    .required(),
  openingHours: Joi.object({
    Monday: Joi.string().required(),
    Tuesday: Joi.string().required(),
    Wednesday: Joi.string().required(),
    Thursday: Joi.string().required(),
    Friday: Joi.string().required(),
    Saturday: Joi.string().required(),
    Sunday: Joi.string().required()
  }),
  paymentOptions: Joi.array().items(
    Joi.string().required()
  ),
  active: Joi.boolean().required(),
  pointsId: Joi.number().integer()
})

const validationPointsRequest = Joi.object({
  userId: Joi.string().guid({
    version: [
      'uuidv4'
    ]
  }).required(),
  establishmentId: Joi.number()
    .integer()
    .required(),
  points: Joi.number()
    .integer()
    .required()
})

const validationUserRequest = Joi.object({
  id: Joi.string().guid({
    version: [
      'uuidv4'
    ]
  }).required(),
  username: Joi.string().required(),
  name: Joi.string().required(),
  email: Joi.string().required(),
  email_verified: Joi.string().required(),
  birthdate: Joi.string().required(),
  phone_number: Joi.string().required()
})

const validationCashbackValueRequest = Joi.object({
  userId: Joi.string().guid({
    version: [
      'uuidv4'
    ]
  }).required(),
  establishmentId: Joi.number()
    .integer()
    .required(),
  cashback: Joi.number()
    .required()
})

const validationRegisterBlacklist = Joi.object({
  // id: Joi.required(),
  nome: Joi.string().min(3).required(),
  documento: Joi.string().min(9).max(11),
  observacao: Joi.string(),
  data: Joi.string().required(),
  id_usuario: Joi.required()
})

const validationRegisterLista = Joi.object({
  id_estabelecimento: Joi.required(),
  nome: Joi.string().required(),
  cor: Joi.string().required(),
  valor: Joi.string(),
  data_cadastro: Joi.string(),
  fb: Joi.allow(null),
  status: Joi.string(),
  sexo: Joi.string(),
  consumacao: Joi.number()
})

const validationRegisterUser = Joi.object({
  nome: Joi.string().required(),
  idCognito: Joi.string(),
  slug: Joi.string().required(),
  documento: Joi.string().min(11).required(),
  email: Joi.string().email().required(),
  celular: Joi.string().min(9).required(),
  senha: Joi.string().required(),
  data_cadastro: Joi.string().required(),
  instagram: Joi.string(),
  facebook: Joi.string(),
  comum: Joi.boolean(),
  email_validado: Joi.boolean(),
  id_cidade: Joi.string(),
  endereco: Joi.string(),
  latitude: Joi.string(),
  longitude: Joi.string(),
  colaborador_parceiro_oc: Joi.boolean()
})

const validationRegisterEstabelecimento = Joi.object({
  id: Joi.required(),
  id_usuario: Joi.required(),
  id_tipo_1: Joi.required(),
  id_tipo_2: Joi.required(),
  id_tipo_3: Joi.required(),
  id_regiao: Joi.required(),
  preco: Joi.string(),
  descricao: Joi.string(),
  hora_inicio: Joi.string(),
  hora_fim: Joi.string(),
  foto: Joi.string(),
  endereco: Joi.string(),
  site: Joi.string(),
  vallet: Joi.boolean()
})

const validationRegisterHashtag = Joi.object({
  id: Joi.required(),
  hashtag: Joi.string().required(),
  id_estabelecimento: Joi.required()
})

const validationRegisterEstabelecimentoTipo = Joi.object({
  id: Joi.required(),
  tipo: Joi.string().required()
})

const validationRegisterMeioPagamento = Joi.object({
  id: Joi.required(),
  id_usuario: Joi.required(),
  is_show: Joi.boolean().required(),
  is_dinheiro: Joi.boolean().required(),
  is_credito: Joi.boolean().required(),
  is_debito: Joi.boolean().required(),
  vale_refeicao: Joi.string().required()
})

const validationRegisterConfiguracaoCardapio = Joi.object({
  id: Joi.required(),
  id_usuario: Joi.required(),
  is_wpp: Joi.boolean(),
  entrega: Joi.number(),
  is_entrega: Joi.boolean().required(),
  is_retirar: Joi.boolean().required(),
  telefone: Joi.string().required(),
  nascimento: Joi.string().required(),
  is_exige_login: Joi.boolean(),
  hora_inicio: Joi.string(),
  hora_fim: Joi.string(),
  wifi_rede: Joi.string(),
  wifi_senha: Joi.string(),
  tipo_estabelecimento: Joi.string(),
  observacao: Joi.string(),
  tempo_entrega: Joi.string(),
  cor_cardapio: Joi.string(),
  is_template_novo: Joi.boolean(),
  is_avaliacao: Joi.boolean()
})

const validationRegisterHorarioFuncionamento = Joi.object({
  id: Joi.number().integer().required(),
  id_usuario: Joi.number().integer().required(),
  is_show: Joi.boolean(),
  seg_inicio: Joi.string(),
  seg_inicio2: Joi.string(),
  seg_fim: Joi.string(),
  seg_fim2: Joi.string(),
  ter_inicio: Joi.string(),
  ter_inicio2: Joi.string(),
  ter_fim: Joi.string(),
  ter_fim2: Joi.string(),
  qua_inicio: Joi.string(),
  qua_inicio2: Joi.string(),
  qua_fim: Joi.string(),
  qua_fim2: Joi.string(),
  qui_inicio: Joi.string(),
  qui_inicio2: Joi.string(),
  qui_fim: Joi.string(),
  qui_fim2: Joi.string(),
  sex_inicio: Joi.string(),
  sex_inicio2: Joi.string(),
  sex_fim: Joi.string(),
  sex_fim2: Joi.string(),
  sab_inicio: Joi.string(),
  sab_inicio2: Joi.string(),
  sab_fim: Joi.string(),
  sab_fim2: Joi.string(),
  dom_inicio: Joi.string(),
  dom_inicio2: Joi.string(),
  dom_fim: Joi.string(),
  dom_fim2: Joi.string(),
  seg_inicio_delivery: Joi.string(),
  seg_fim_delivery: Joi.string(),
  ter_inicio_delivery: Joi.string(),
  ter_fim_delivery: Joi.string(),
  qua_inicio_delivery: Joi.string(),
  qua_fim_delivery: Joi.string(),
  qui_inicio_delivery: Joi.string(),
  qui_fim_delivery: Joi.string(),
  sex_inicio_delivery: Joi.string(),
  sex_fim_delivery: Joi.string(),
  sab_inicio_delivery: Joi.string(),
  sab_fim_delivery: Joi.string(),
  dom_inicio_delivery: Joi.string(),
  dom_fim_delivery: Joi.string()
})

const validationRegisterColaboradorFixo = Joi.object({
  nome: Joi.string().required(),
  data_cadastro: Joi.date().required(),
  cor: Joi.string(),
  promoter: Joi.boolean().required(),
  hostess: Joi.boolean().required(),
  gerente: Joi.boolean().required(),
  estabelecimento: Joi.number().required(),
  id_usuario: Joi.number().required()
})

const validationRegisterFraseWpp = Joi.object({
  frase: Joi.string().required(),
  id_usuario: Joi.number().required()
})

const validationRegisterCategoria = Joi.object({
  titulo: Joi.string().required(),
  id_usuario: Joi.number().required(),
  visivel: Joi.boolean().required(),
  tipoCardapio: Joi.string().required()
})

const validationRegisterCategoriaGrupe = Joi.object({
  id_categoria: Joi.number().required(),
  titulo: Joi.string().required()
})

const validationRegisterCategoriaProduto = Joi.object({
  titulo: Joi.string().required(),
  detalhe: Joi.string(),
  id_categoria: Joi.number().required(),
  preco: Joi.number().required(),
  tipo: Joi.string(),
  visivel: Joi.boolean(),
  ordem: Joi.number(),
  qtd_subitens: Joi.number(),
  subitens_extra: Joi.boolean(),
  id_grupo: Joi.number(),
  vegetariano: Joi.boolean().required(),
  vegano: Joi.boolean().required(),
  gluten: Joi.boolean().required(),
  lactose: Joi.boolean().required(),
  alcool: Joi.boolean().required(),
  qtd_pessoas: Joi.number(),
  tipo_cardapio: Joi.string(),
  ocultar_preco: Joi.boolean().required(),
  destaque: Joi.boolean().required()
})

const verifyData = async (tipo, authorizer, id) => {
  const dbConnection = await connection()

  const userContext = userAttributesPick(authorizer)

  if (!userContext) {
    throw new Error('user not found!')
  }

  const user = await dbConnection.model('Users').findOne({
    where: {
      idCognito: userContext.id
    }
  })

  if (!user) {
    throw new Error('user not found!')
  }

  switch (tipo) {
    case 'User': {
      return { user }
    }
    case 'Estabelecimento': {
      const estabelecimento = await dbConnection.model('ocEstabelecimento').findOne({
        where: {
          id_usuario: user.id
        }
      })
      return { user, estabelecimento }
    }
    case 'Evento': {
      if (user?.documento === 11) {
        const colaborador = await dbConnection.model('eveColaborador').findOne({
          where: { eveUsuario: user.id },
          include:
            {
              model: dbConnection.model('EveFuncao'),
              include: {
                model: dbConnection.model('EveFuncaoAcessos')
              }
            }
        })

        if (colaborador !== null) {
          const evento = await dbConnection.model('EveEvento').findOne({
            where: {
              eveUsuario: user.id,
              id: id
            }
          })
          console.log('User: %s, Evento: %s, Colaborador: %s', user, evento, colaborador)
          return { user, evento, colaborador }
        }
      } else {
        const evento = await dbConnection.model('EveEvento').findOne({
          where: {
            eveUsuario: user.id,
            id: id
          }
        })
        console.log('User: %s, Evento: %s', user, evento)
        return { user, evento }
      }
      break
    }
    default:
      break
  }
}

module.exports = {
  validationEstablishmentRequest,
  validationPointsRequest,
  validationUserRequest,
  validationCashbackValueRequest,
  validationRegisterBlacklist,
  validationRegisterLista,
  validationRegisterUser,
  validationRegisterEstabelecimento,
  validationRegisterHashtag,
  validationRegisterEstabelecimentoTipo,
  validationRegisterMeioPagamento,
  validationRegisterConfiguracaoCardapio,
  validationRegisterHorarioFuncionamento,
  validationRegisterColaboradorFixo,
  validationRegisterFraseWpp,
  validationRegisterCategoria,
  validationRegisterCategoriaGrupe,
  validationRegisterCategoriaProduto,
  verifyData
}
