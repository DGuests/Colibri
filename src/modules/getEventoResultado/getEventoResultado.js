'use strict'

const { BaseHandlerLambda } = require('@src/lib')
const connection = require('@src/models')
const { obterIdUsuario } = require('../../utils/index')

class GetEventoResultado extends BaseHandlerLambda {
  async main(event) {
    console.log('🚀 ~ file: GetEventoResultado.js ~ line 8 ~ GetEventoResultado ~ main ~ event', event)
    try {
      const dbConnection = await connection()
      const idUser = obterIdUsuario(event)

      const user = await dbConnection.model('Users').findOne({
        where: {
          idCognito: idUser
        }
      })

      if (!user) {
        throw new Error('user not found!')
      }

      const [[counts]] = await dbConnection.query(`
      SELECT
      COUNT(DISTINCT CASE WHEN s_lst_email  IS NOT NULL THEN s_lst_email END) as linkPromover,
      COUNT(CASE WHEN t_data_checkin IS NOT NULL THEN 1 END) as checkin,
      COUNT(*) as lista,
      AVG(CASE WHEN t_lst_nasc IS NOT NULL AND DATEDIFF(CURDATE(), t_lst_nasc) / 365.25 BETWEEN 18 AND 70 THEN DATEDIFF(CURDATE(), t_lst_nasc) / 365.25 END) AS media_idade,
      COUNT(CASE WHEN e_lst_sexo = 'm' THEN 1 END) as total_convidados_masculino,
      COUNT(CASE WHEN e_lst_sexo = 'f' THEN 1 END) as total_convidados_feminino,
      COUNT(CASE WHEN e_lst_sexo = 'm' AND t_data_checkin IS NOT NULL THEN 1 END) as total_presentes_masculino,
      COUNT(CASE WHEN e_lst_sexo = 'f' AND t_data_checkin IS NOT NULL THEN 1 END) as total_presentes_feminino,
      COUNT(CASE WHEN tb_eve_lista_tipos.s_lista_tipo_valor IS NULL THEN 1 END) as total_convidados_nao_pagantes,
      COUNT(CASE WHEN tb_eve_lista_tipos.s_lista_tipo_valor IS NOT NULL THEN 1 END) as total_convidados_pagantes,
      COUNT(CASE WHEN t_data_checkin IS NOT NULL AND tb_eve_lista_tipos.s_lista_tipo_valor IS NULL THEN 1 END) as total_presentes_nao_pagantes,
      COUNT(CASE WHEN t_data_checkin IS NOT NULL AND tb_eve_lista_tipos.s_lista_tipo_valor IS NOT NULL THEN 1 END) as total_presentes_pagantes
    FROM
      tb_eve_lista
    LEFT JOIN
      tb_eve_lista_tipos ON tb_eve_lista.f_lst_tipo = tb_eve_lista_tipos.p_lista_tipo_id
    WHERE
      f_lst_evento = ${event.pathParameters.idEvento}
      `);

      const [checkinHorarios] = await dbConnection.query(`
      SELECT t_data_checkin AS label, COUNT(*) AS data
    FROM
      tb_eve_lista
    WHERE
      f_lst_evento = ${event.pathParameters.idEvento}
      AND t_data_checkin IS NOT NULL
      AND t_data_checkin != 'Invalid Date'
    GROUP BY
    label
    ORDER BY
    label
      `);

      const [idadeConvidados] = await dbConnection.query(`
      SELECT ROUND(DATEDIFF(CURDATE(), t_lst_nasc) / 365.25) as label, COUNT(*) as data
    FROM
      tb_eve_lista
    WHERE
      f_lst_evento = ${event.pathParameters.idEvento}
      AND t_lst_nasc IS NOT NULL
    GROUP BY
    label
    ORDER BY
    label
      `);

      const [idadePresentes] = await dbConnection.query(`
      SELECT ROUND(DATEDIFF(CURDATE(), t_lst_nasc) / 365.25) as label, COUNT(*) as data
    FROM
      tb_eve_lista
    WHERE
      f_lst_evento = ${event.pathParameters.idEvento}
      AND t_lst_nasc IS NOT NULL
      AND t_data_checkin IS NOT NULL
    GROUP BY
    label
    ORDER BY
    label
      `);

      const [convidadosPorDia] = await dbConnection.query(`
      SELECT DATE_FORMAT(createdAt, '%Y-%m-%d') as label, COUNT(*) as data
    FROM
      tb_eve_lista
    WHERE
      f_lst_evento = ${event.pathParameters.idEvento}
    GROUP BY
    label
    ORDER BY
    label
      `);

      const [aniversariosPorDia] = await dbConnection.query(`
        SELECT DATE_FORMAT(createdAt, '%Y-%m-%d') as label, COUNT(*) as data
        FROM tb_eve_aniversarios
        WHERE f_ani_evento = ${event.pathParameters.idEvento} AND f_ani_tipo = 1
        GROUP BY label
        ORDER BY label
      `);

      const [colaboradores] = await dbConnection.query(`
      SELECT
      tee.t_eve_data_evento AS dataEvento,
      tee.p_eve_id AS id_evento,
      tuu.s_usu_nome AS colaborador,
      tec.p_col_eve_id AS id_colaborador,
      telt.s_lista_tipo_nome AS nome_da_lista,
      telt.s_lista_tipo_cor AS cor,
      COUNT(tel.f_lst_tipo) AS total_nomes_lista,
      COUNT(tel.t_lst_data_checkin) AS total_check_in
      FROM tb_eve_evento tee
        JOIN tb_eve_colaborador tec ON tee.p_eve_id = tec.f_eve_id
        JOIN tb_usu_usuario tuu  ON tuu.p_usu_id  = tec.f_col_id
        JOIN tb_eve_lista tel ON tel.f_lst_convidado_por = tec.p_col_eve_id
        JOIN tb_eve_lista_tipos telt ON tel.f_lst_tipo = telt.p_lista_tipo_id
      WHERE tee.p_eve_id = ${event.pathParameters.idEvento} AND tee.f_eve_usuario = ${user.id} AND tec.f_bnf_id = 1
      GROUP BY tee.p_eve_id, tec.p_col_eve_id, tel.f_lst_tipo;
      `)

      return this.handlerSuccess({ counts, checkinHorarios, idadeConvidados, idadePresentes, convidadosPorDia, aniversariosPorDia, colaboradores })
    } catch (error) {
      console.log("🚀 ~ file: GetEventoResultado.js ~ line 21 ~ GetEventoResultado ~ main ~ error", error)
      return this.handleError(error)
    }
  }
}



const getEventoResultado = new GetEventoResultado()

module.exports = getEventoResultado.main.bind(getEventoResultado)
