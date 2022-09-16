import IUserCreateReqDto
    from "@usecases/user/create/IUserCreateReqDto";
import IUserLoginReqDto
    from "@usecases/user/login/IUserLoginReqDto";
import IPaginationSetDto
    from "@usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@usecases/filter/add/IFilterSetDto";
import IUserUpdateReqDto
    from "@usecases/user/update/IUserUpdateReqDto";
import IUserDeleteReqDto
    from "@usecases/user/delete/IUserDeleteReqDto";
import IApplicantCreateResDto
    from "@usecases/applicant/create/IApplicantCreateResDto";
import IApplicantCreateReqDto
    from "@usecases/applicant/create/IApplicantCreateReqDto";
import INewsCreateReqDto
    from "@usecases/jobad/create/INewsCreateReqDto";

type ApiResponse = {
    name: string;
    message: string;
}

export default class BaseService {
    private static API_HOST = process.env.REACT_APP_API_HOST || "http://localhost:4005/api";
    private readonly api_url;
    private readonly headers;
    private readonly resource;

    constructor(resource: string) {
        this.resource = resource;
        this.api_url = `${BaseService.API_HOST}`;
        this.headers = new Headers();
        this.headers.set('Content-Type', 'application/json');
    }

    getApiUrl() {
        return this.api_url;
    }

    getResource() {
        return this.resource;
    }

    getHeaders() {
        return this.headers;
    }

    async create(baseModel: IUserCreateReqDto | IApplicantCreateReqDto | INewsCreateReqDto) {
        const url = `${this.api_url}/${this.getResource()}/create`;

        const params = {
            method: "POST",
            headers: this.headers,
            body: JSON.stringify(baseModel)
        };

        const checkResp = (resp: Response) => {
            if (resp.status !== 201) throw resp.json();
        }

        const throwError = (err: ApiResponse) => {
            throw err;
        }

        const results = await fetch(url, params)
            .then((resp: Response) => {
                checkResp(resp);
                return resp.json();
            })
            .catch(throwError);

        if (typeof results === 'undefined' || results.errors) {
            if (typeof results === 'undefined') throw Error(`La API REST se encunetra fuera de servicio, puede comprobar su funcionamiento ingresando a ${this.api_url}`);
            return null;
        }

        return results;
    }

    async login(baseModel: IUserLoginReqDto) {
        const url = `${this.api_url}/${this.getResource()}/login`;

        const params = {
            method: "POST",
            headers: this.headers,
            body: JSON.stringify(baseModel)
        };

        const checkResp = (resp: Response) => {
            if (resp.status !== 200) throw resp.json();
        }

        const throwError = (err: ApiResponse) => {
            throw err;
        }

        const results = await fetch(url, params)
            .then((resp: Response) => {
                checkResp(resp);
                return resp.json();
            })
            .catch(throwError);

        if (typeof results === 'undefined' || results.errors) {
            if (typeof results === 'undefined') throw Error(`La API REST se encunetra fuera de servicio, puede comprobar su funcionamiento ingresando a ${this.api_url}`);
            return null;
        }

        return results;
    }

    async findAllByFilters(pagination?: IPaginationSetDto, filters?: IFilterSetDto[]) {
        // console.log("pagination",pagination,"filters",filters);
        let url = new URL(`${this.api_url}/${this.getResource()}`);
        pagination?.size && url.searchParams.append("size", pagination?.size.toString());
        pagination?.page && url.searchParams.append("page", pagination?.page.toString());
        !!filters?.length && filters.map((filter: IFilterSetDto )=>{
            if(!!filter.key && !!filter.value) {
                // console.log("filter", filter);
                url.searchParams.append(filter.key, filter.value);
            }
        })

        const params = {
            method: "GET",
            headers: this.headers,
        };

        const checkResp = (resp: Response) => {
            if (resp.status !== 200) throw resp.json();
        }

        const throwError = (err: ApiResponse) => {
            throw err;
        }

        const results = await fetch(url.toString(), params)
            .then((resp: Response) => {
                checkResp(resp);
                return resp.json();
            })
            .catch(throwError);

        if (typeof results === 'undefined' || results.errors) {
            if (typeof results === 'undefined') throw Error(`La API REST se encunetra fuera de servicio, puede comprobar su funcionamiento ingresando a ${this.api_url}`);
            return null;
        }

        return results;
    }

    async replace(
        baseModel:  IUserCreateReqDto | IApplicantCreateReqDto | INewsCreateReqDto,
        userId: number) {
        let url = new URL(`${this.api_url}/${this.getResource()}`);
        url.searchParams.append('id', userId.toString());

        const params = {
            method: "PUT",
            headers: this.headers,
            body: JSON.stringify(baseModel)
        };

        const checkResp = (resp: Response) => {
            if (resp.status !== 200) throw resp.json();
        }

        const throwError = (err: ApiResponse) => {
            throw err;
        }

        const results = await fetch(url.toString(), params)
            .then((resp: Response) => {
                checkResp(resp);
                return resp.json();
            })
            .catch(throwError);

        if (typeof results === 'undefined' || results.errors) {
            if (typeof results === 'undefined') throw Error(`La API REST se encunetra fuera de servicio, puede comprobar su funcionamiento ingresando a ${this.api_url}`);
            return null;
        }

        return results;
    }

    async delete(userId: number) {
        let url = new URL(`${this.api_url}/${this.getResource()}`);
        url.searchParams.append('id', userId.toString());

        const params = {
            method: "DELETE",
            headers: this.headers,
            // body: JSON.stringify(idUser.toString())
        };

        const checkResp = (resp: Response) => {
            if (resp.status !== 200) throw resp.json();
        }

        const throwError = (err: ApiResponse) => {
            throw err;
        }

        const results = await fetch(url.toString(), params)
            .then((resp: Response) => {
                checkResp(resp);
                return resp.json();
            })
            .catch(throwError);

        if (typeof results === 'undefined' || results.errors) {
            if (typeof results === 'undefined') throw Error(`La API REST se encunetra fuera de servicio, puede comprobar su funcionamiento ingresando a ${this.api_url}`);
            return null;
        }

        return results;
    }
}
