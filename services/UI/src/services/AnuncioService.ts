import BaseService from "./BaseService";

export default class AnuncioService extends BaseService {
    private static API_RESOURCE = "news";

    constructor() {
        super(AnuncioService.API_RESOURCE);
    }
}
