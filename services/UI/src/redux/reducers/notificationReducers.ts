export default (state:any = {
                    messages: [],
                },
                action:any) => {
    switch (action.type) {
        case "ENQUEUE_NOTIFICATION":
            if (!action.payload) return state;
            return {
                ...state,
                messages: [...state.messages, {...action.payload.message}],
            };
        default:
            return state;
    }
}
