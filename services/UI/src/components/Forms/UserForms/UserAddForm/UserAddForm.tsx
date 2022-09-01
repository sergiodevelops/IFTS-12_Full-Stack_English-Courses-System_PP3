import React, {useEffect, useRef, useState} from 'react';
import {useDispatch, useSelector} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import FormControl from '@material-ui/core/FormControl';
import Autocomplete from '@material-ui/lab/Autocomplete';
import {InputAdornment} from "@material-ui/core";
import IconButton from "@mui/material/IconButton";
import {Visibility, VisibilityOff} from "@mui/icons-material";
import Container from "@material-ui/core/Container";
import userActions from "@redux/actions/userActions";
import userTypes from "@constants/userTypes";
import UsuarioService from "@services/UsuarioService";
import useStyles from "./styles";
import IUserCreateReqDto
    from "@usecases/user/create/IUserCreateReqDto";
import {RootState} from "@redux/reducers/allReducers";
import Typography from "@mui/material/Typography";

export default function UserAddForm(props: { title: string }) {
    const userLoggedStore = useSelector((state: RootState) => state?.userReducers?.currentUser);
    const [currentLoggedUser, setCurrentLoggedUser] = useState(userLoggedStore);
    const usuarioService = new UsuarioService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const dispatch = useDispatch();
    // const usersListStore = useSelector((state) => state?.userReducers.usersList);
    const classes = useStyles();
    const emptyUser = {
        userType: 0,
        userFullname: "",
        username: "",
        password: "",
    };
    const [newUser, setNewUser] = useState(emptyUser);
    const [userType, setUserType] = useState<{id:number,name:string,description:string}>(userTypes[0] || {id:0,name:"",description:""});
    const [password2, setPassword2] = useState("");
    const [userExistInDB, setUserExistInDB] = useState(false);
    const [showPassword1, setShowPassword1] = useState(false);
    const [showPassword2, setShowPassword2] = useState(false);

    useEffect(() => {
        setCurrentLoggedUser(userLoggedStore)
    }, [userLoggedStore]);

    useEffect(() => {
        setUserType(userTypes.find((userType:{id:number,name:string,description:string})=>userType.id === newUser.userType) || {id:0,name:"",description:""});
    }, [newUser]);

    useEffect(() => {
        const listener = (event: KeyboardEvent) => {
            if (event.code === "Enter" || event.code === "NumpadEnter") {
                event.preventDefault();
                buttonRef?.current?.click();
            }
        };
        document.addEventListener("keyup", listener);
        return () => document.removeEventListener("keyup", listener);
    }, [buttonRef]);

    const handleClickShowPassword1 = () => setShowPassword1(!showPassword1);
    const handleClickShowPassword2 = () => setShowPassword2(!showPassword2);
    const cleanInputValues = () => {
        setNewUser(emptyUser);
        setPassword2("");
        setUserExistInDB(false);
        setUserType({id:0,name:"",description:""});
    }
    // const handleClick = async () => {
    //     const userExist = await usersListStore && usersListStore.findIndex((user) =>
    //         user.username === newUser.username) !== -1;
    //     if (userExist) {
    //         const message = "El usuario ya existe, intente con un username diferente";
    //         // dispatch(notificationActions.enqueueMessage(message)); //TODO ver despues snackbar integration
    //         alert(message);
    //     } else {
    //         dispatch(userActions.addNewUser(newUser));
    //         dispatch(userActions.setCurrentAuthenticatedUser(newUser));
    //         cleanInputValues();
    //     }
    // };

    const saveUser = async () => {
        let message;
        if (!newUser.userType ||
            !newUser.userFullname ||
            !newUser.username ||
            !newUser.password) {
            message = "Por favor complete los campos requeridos";
            alert(message);
            // store.dispatch(notifierActions.enqueueNotification(new Notification('error', 'Error', 'Por favor complete los campos requeridos')));
            return;
        }
        const newUserPost: IUserCreateReqDto = {
            tipo_usuario: newUser?.userType, // mapeo para la base, envia un number
            nombre_completo: newUser?.userFullname,
            username: newUser?.username,
            password: newUser?.password,
        };

        usuarioService
            .create(newUserPost)
            .then(createdUser => {
                // console.log("createdUser en FE ", createdUser);
                !currentLoggedUser && dispatch(userActions.setCurrentAuthenticatedUser(createdUser));
                alert(`El usuario "${newUser.username}" se persistió correctamente`);
                cleanInputValues();
            })
            .catch(err => {
                err.then((err: Error) => {
                        console.error("ERROR en FE", err.message);
                        alert(`${err.message}`);
                        setUserExistInDB(true);
                    }
                )
            });
    };

    const validateInputData = (e: React.ChangeEvent<HTMLTextAreaElement | HTMLInputElement>, typeText: string) => {
        const inputDataChecked = e.target.value.replace(/ /g, "");
        if (typeText === "username") return inputDataChecked.toLowerCase();
        return inputDataChecked;
    }

    return (
        <Grid container>
            <Grid item xs={12}>
                <Typography variant={"h4"}
                            noWrap
                            className={classes.addFormTitle}
                            component={"div"}
                            textAlign={'center'}
                            marginY={'2vh'}
                >
                    {props?.title}
                </Typography>
                {/*<h1 className={classes.titulo}>{props?.title || "Alta de registro"}</h1>*/}
            </Grid>

            <Container className={classes.root} maxWidth="xs">
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        <Grid item xs={12}>
                            <FormControl
                                variant="outlined"
                                className={classes.formControl}
                            >
                                <Autocomplete
                                    className={`userType`}
                                    disableClearable
                                    aria-readonly={'true'}
                                    disabled={!newUser}
                                    options={userTypes}
                                    getOptionLabel={(option) => option.description || ""}
                                    value={userType}
                                    onChange={(e, selectedOption) => setNewUser({
                                        ...newUser,
                                        userType: selectedOption?.id || 0,
                                    })}
                                    style={{width: 300}}
                                    renderInput={(params) =>
                                        <TextField
                                            {...params}
                                            error={!newUser?.userType}
                                            label="Seleccionar una opción"
                                            variant="outlined"
                                        />}
                                />
                            </FormControl>
                        </Grid>
                        <Grid item xs={12}>
                            <TextField
                                className={`userFullname`}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newUser.userType}
                                value={!!newUser?.userType && newUser?.userFullname || ""}
                                error={!!newUser.userType && !newUser.userFullname}
                                onChange={(e) => setNewUser({
                                    ...newUser,
                                    userFullname: e.target.value.toLowerCase()
                                })}
                                label="Nombres y apellidos"
                                name="userFullname"
                                size="small"
                                type="text"
                                variant="outlined"
                            />
                        </Grid>
                        <Grid item xs={12}>
                            <TextField
                                className={`username`}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newUser?.userFullname}
                                value={!!newUser?.userFullname && newUser?.username || ""}
                                error={!!newUser?.userFullname && !newUser?.username || userExistInDB}
                                helperText={userExistInDB && "Este usuario ya existe, ingrese otro por favor"}
                                onChange={(e) => {
                                    setNewUser({
                                        ...newUser,
                                        username: validateInputData(e, "username"),
                                    });
                                    setUserExistInDB(false);
                                }}
                                label="Usuario"
                                name="username"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>
                        <Grid item xs={12}>
                            <TextField
                                className={`password`}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newUser?.username}
                                value={!!newUser?.username && !!newUser?.password ? newUser.password : ""}
                                error={!!newUser?.username && (!newUser?.password || newUser?.password !== password2)}
                                label="Contraseña"
                                name="password1"
                                size="small"
                                variant="outlined"
                                onChange={(e) => setNewUser({
                                    ...newUser,
                                    // password: e.target.value
                                    password: validateInputData(e, "password"),
                                })}
                                type={showPassword1 ? "text" : "password"}
                                InputProps={{
                                    endAdornment: (
                                        <InputAdornment position="end">
                                            <IconButton
                                                aria-label="toggle password visibility"
                                                onClick={handleClickShowPassword1}
                                                disabled={!newUser.username}
                                            >
                                                {showPassword1 ? <Visibility/> :
                                                    <VisibilityOff/>}
                                            </IconButton>
                                        </InputAdornment>
                                    )
                                }}
                            />
                        </Grid>
                        <Grid item xs={12}>
                            <TextField
                                className={`password2`}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newUser.username}
                                value={newUser.username && newUser.password && password2 ? password2 : ""}
                                error={!!newUser?.username && (!newUser?.password || newUser?.password !== password2)}
                                label="Confirmar contraseña"
                                name="password2"
                                size="small"
                                variant="outlined"
                                onChange={
                                    (e) =>
                                        setPassword2(validateInputData(e, "password2"))
                                }
                                type={showPassword2 ? "text" : "password"}
                                InputProps={{
                                    endAdornment: (
                                        <InputAdornment position="end">
                                            <IconButton
                                                aria-label="toggle password visibility"
                                                onClick={handleClickShowPassword2}
                                                disabled={!newUser.username}
                                            >
                                                {showPassword2 ? <Visibility/> :
                                                    <VisibilityOff/>}
                                            </IconButton>
                                        </InputAdornment>
                                    )
                                }}
                            />
                        </Grid>
                    </Grid>
                </Grid>

                <Grid container spacing={3}>
                    <Grid item xs={12}>
                        <Button
                            ref={buttonRef}
                            autoFocus={true}
                            color={"primary"}
                            fullWidth type="submit" variant="contained"
                            disabled={!newUser.userType || !newUser.userFullname || !newUser.username || !newUser.password || newUser.password !== password2}
                            onClick={saveUser}
                        >
                            crear
                        </Button>
                    </Grid>
                </Grid>
            </Container>
        </Grid>
    );
};
