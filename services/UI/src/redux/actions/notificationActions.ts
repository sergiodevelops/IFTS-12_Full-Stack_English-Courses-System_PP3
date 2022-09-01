const enqueueMessage = (message:any) => {
    return {
        type: "ENQUEUE_NOTIFICATION",
        payload: {
            message,
        },
    }
};

export default { enqueueMessage }
