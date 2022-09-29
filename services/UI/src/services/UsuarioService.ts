import BaseService from "./BaseService";

export default class UsuarioService extends BaseService {
    private static API_RESOURCE = "user";

    constructor() {
        super(UsuarioService.API_RESOURCE);
    }
}
