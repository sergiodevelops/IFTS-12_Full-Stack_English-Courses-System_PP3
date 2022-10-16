export default class Filter {
    public filters: { [name: string]: any };
    public key: string;

    constructor(key: string, filters?: { [name: string]: any }) {
        this.filters = filters || {};
        this.key = key;
    }

    setfilters(filters: { [name: string]: any }) {
        const newFilters = { ...this.filters, ...filters };
        return new Filter(this.key, newFilters);
    }

    public static create(object: any): Filter {
        return new Filter(object["key"], object["filters"])
    }
}
