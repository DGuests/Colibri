"use strict";

const { BaseHandlerLambda } = require("@src/lib");
// const { validationUserRequest } = require('@src/utils/validator')

const connection = require("@src/models");
const Sequelize = require("sequelize");

class verifyUser extends BaseHandlerLambda {
  async main(event) {
    try {
      const dbConnection = await connection();

      const user = await dbConnection.model("Users").findOne({
        where: {
          [Sequelize.Op.or]: [
            { documento: event.pathParameters.documento },
            { slug: event.pathParameters.slug },
          ],
        },
      });
      console.log("🚀 ~ verifyUser ~ user ~ user:", user);

      if (!user) {
        return this.handlerSuccess(true);
      }
      return this.handlerSuccess(false);
    } catch (error) {
      console.log(
        "🚀 ~ file: findUser.js ~ line 38 ~ FindUser ~ main ~ error",
        error
      );
      return this.handleError(error);
    }
  }
}

const VerifyUser = new verifyUser();

module.exports = VerifyUser.main.bind(VerifyUser);
