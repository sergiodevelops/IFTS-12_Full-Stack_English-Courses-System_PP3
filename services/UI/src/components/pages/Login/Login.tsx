import React, {useEffect, useState} from 'react';
import {useSelector} from "react-redux";
import UserLoginForm
    from '@components/Forms/UserForms/UserLoginForm/UserLoginForm';
import UserAddForm from '@components/Forms/UserForms/UserAddForm/UserAddForm';
import PrivateCampus from "@components/DoubleSideBar/PrivateCampus";
import {RootState} from "@redux/reducers/allReducers";
import {ActionButton} from "@components/ActionButton/ActionButton";
import UsuarioService from "@src/services/UsuarioService";
import IUserFindResDto from "@src/usecases/user/find/IUserFindResDto";
import IPaginationSetDto
    from "@src/usecases/pagination/set/IPaginationSetDto";
import IFilterSetDto from "@src/usecases/filter/add/IFilterSetDto";
import useStyles from "./styles";

export default function Login() {
    const classes = useStyles();
    const userIsLoggedIn: boolean = !!useSelector((state: RootState) => state?.userReducers.currentUser);
    // usuario esta logueado o no?
    const [sesionActiva, setSesionActiva] = useState<boolean>(userIsLoggedIn);
    // pantalla de login o de autenticación?
    const [loginMode, setLoginMode] = useState<boolean>(true);
    const [foundAnyUserInDb, setFoundAnyUserInDb] = useState<boolean>(true);

    const usuarioService = new UsuarioService();
    const checkIfExistAnyAdminUserInDb = async () => {
        const pagination: IPaginationSetDto = {size: 1, page: 0};
        const filters: IFilterSetDto[] = [{key: 'tipo_usuario', value: '1'}];
        usuarioService
            .findAllByFilters(pagination, filters)
            .then((response: IUserFindResDto) => {
                // console.log("checkIfExistAnyAdminUserInDb", response);
                // !!response.users.length ?
                //     console.log("ya existe al menos 1 user") :
                //     console.log("no existe ningun usuario crea uno");
                setLoginMode(!!response.users.length);
            })
            .catch((err: any) => {
                // err.then((err: any) => {
                        setLoginMode(true);
                        setSesionActiva(false);
                        console.error("ERROR en FE", err.message);
                    // }
                // );
            });
    };

    const handleClick = () => {
        setLoginMode(!loginMode)
    };

    useEffect(() => {
        checkIfExistAnyAdminUserInDb();
        setSesionActiva(userIsLoggedIn);
    }, [userIsLoggedIn])

    return (
        <div
            style={{minHeight: '100vh'}}
            className={`${classes.backImage} ${loginMode ? 
                classes.principal : 
                classes.nosotros}`}
        >
            {sesionActiva ?
                <PrivateCampus/> :
                <div>
                    <div onClick={handleClick}>
                        <ActionButton authMode={loginMode}/>
                    </div>

                    {loginMode ?
                        <UserLoginForm/> :
                        <UserAddForm
                            title={"Crear una nueva cuenta"}/>}
                </div>
            }
        </div>
    );
};
