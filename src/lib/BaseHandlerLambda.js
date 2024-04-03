class BaseHandlerLambda {
  handlerSuccess (data) {
    return {
      statusCode: 200,
      headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': true
      },
      body: JSON.stringify(data)
    }
  }

  handleError (data) {
    return {
      statusCode: data.statusCode || 500,
      headers: { 'Content-Type': 'text/plain' },
      body: data.message || 'Internal ServerError!!!!'
    }
  }

  parseEvent (event) {
    return event.body ? JSON.parse(event.body) : event
  }
}

module.exports = BaseHandlerLambda
