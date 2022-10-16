import * as React from 'react';
import Box from '@mui/material/Box';
import Button from '@mui/material/Button';
import Typography from '@mui/material/Typography';
import Modal from '@mui/material/Modal';
import {useDispatch, useSelector} from "react-redux";
import {RootState} from "@redux/reducers/allReducers";
import {JSXElementConstructor, useEffect} from "react";
import layoutActions from "@redux/actions/layoutActions";
// import UserLoginForm
//     from "@components/Forms/UserForms/UserLoginForm/UserLoginForm";
// import UserAddForm from "@components/Forms/UserForms/UserAddForm/UserAddForm";
// import UserUpdateDeleteForm
//     from "@components/Forms/UserForms/UserUpdateDeleteForm/UserUpdateDeleteForm";
// import IUserLoginResDto
//     from "@usecases/user/login/IUserLoginResDto";

const style = {
    position: 'absolute' as 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 400,
    bgcolor: 'background.paper',
    border: '2px solid #000',
    boxShadow: 24,
    p: 4,
};

export default function BasicModal(props: { bodyComponent: React.ReactElement }) {
    const {bodyComponent} = props;
    const dispatch = useDispatch();
    const modalIsOpen = useSelector((state: RootState) => state?.layoutReducers.openModal);

    const [open, setOpen] = React.useState(false);
    const handleClose = () => dispatch(layoutActions.setOpenModal(false));

    useEffect(() => {
        setOpen(modalIsOpen);
    }, [modalIsOpen])

    return (
        <div>
            <Modal
                open={open}
                onClose={handleClose}
                aria-labelledby="modal-modal-title"
                aria-describedby="modal-modal-description"
            >
                <Box sx={style}>
                    {bodyComponent}
                    {/*<UserUpdateDeleteForm registerFormTitle={"Modificar o eliminar"} {...props}/>*/}
                </Box>
            </Modal>
        </div>
    );
}
