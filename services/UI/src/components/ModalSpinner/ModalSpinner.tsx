import React from 'react';
import Modal from "@mui/material/Modal";
import Spinner from "@components/ModalSpinner/Spinner/Spinner";

export default function ModalSpinner() {

    return (
        <Modal aria-labelledby="simple-modal-title"
               aria-describedby="simple-modal-description" open>
            <Spinner/>
        </Modal>
    )
}