import React, {useEffect, useRef, useState} from 'react';
import {useDispatch} from "react-redux";
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import {InputAdornment} from "@material-ui/core";
import IconButton from "@mui/material/IconButton";
import {Visibility, VisibilityOff} from "@mui/icons-material";
import userActions from "@redux/actions/userActions";
import Container from "@material-ui/core/Container";
import UsuarioService from "@services/UsuarioService";
import useStyles from "./styles";
import allActions from "@redux/actions";

export default function UserLoginForm() {
    const usuarioService = new UsuarioService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const classes = useStyles();
    const dispatch = useDispatch();
    // const usersListStore = useSelector((state) =>
    // state.userReducers.usersList);

    const [currentUser, setCurrentUser] = useState({
        username: "",
        password: ""
    });
    const [showPassword, setShowPassword] = useState(false);
    const handleClickShowPassword = () => setShowPassword(!showPassword);

    useEffect(() => {
        const listener = (e: KeyboardEvent) => {
            if (e.code === "Enter" || e.code === "NumpadEnter") {
                e.preventDefault();
                buttonRef?.current?.click();
            }
        };
        document.addEventListener("keyup", listener);
        return () => document.removeEventListener("keyup", listener);
    }, [buttonRef]);

    // const handleClick = async () => {
    //     const authIsCorrect = await usersListStore &&
    // usersListStore.findIndex((user) => user.username ===
    // currentUser.username && user.password === currentUser.password ) !== -1;
    //  const cleanInputValues = () => { setCurrentUser({username: "",
    // password: ""}); }  if (!authIsCorrect) { const message = "El usuario o
    // contraseña no son válidos, intente nuevamente"; //
    // dispatch(notificationActions.enqueueMessage(message));  //TODO ver
    // despues snackbar integration alert(message); } else { //
    // cleanInputValues();
    // dispatch(userActions.setCurrentAuthenticatedUser(currentUser)); } };

    const validateInputData = (e: React.ChangeEvent<HTMLTextAreaElement | HTMLInputElement>, typeText: string) => {
        const inputDataChecked = e.target.value.replace(/ /g, "");
        if (typeText === "username") return inputDataChecked.toLowerCase();
        return inputDataChecked;
    }
    const handleLogIn = async () => {
        if (!currentUser.username ||
            !currentUser.password) {
            alert("Por favor complete los campos requeridos");
            // store.dispatch(notifierActions.enqueueNotification(new
            // Notification('error', 'Error', 'Por favor complete los campos
            // requeridos')));
            return;
        }
        const userToLogin = {
            username: currentUser.username,
            password: currentUser.password
        };

        usuarioService
            .login(userToLogin)
            .then(foundUser => {
                // console.log("foundUser en FE ",foundUser)
                // console.log("foundUser", foundUser);
                dispatch(allActions.userActions.setCurrentAuthenticatedUser(foundUser));
            })
            .catch(err => {
                console.error(err);
                err.then((err: Error) => {
                        console.error("ERROR en FE", err.message);
                        alert(`${err.message}`);
                        // setUserExistInDB(true);
                    }
                )
            });
    };

    return (
        <Grid container>
            <Container className={classes.root} maxWidth="xs">
                <Grid container spacing={2}>
                    <Grid item xs={12}>
                        <h1 className={classes.titulo}>Iniciar sesión</h1>
                    </Grid>
                    <Grid container spacing={2}>
                        <Grid item xs={12}>
                            <TextField
                                className={`user`}
                                autoComplete={"off"}
                                fullWidth
                                value={currentUser.username}
                                label="Usuario"
                                name="Usuario"
                                size="small"
                                variant="outlined"
                                onChange={(e: React.ChangeEvent<HTMLTextAreaElement | HTMLInputElement>) => setCurrentUser({
                                    ...currentUser,
                                    username: validateInputData(e, "username"),
                                })}
                            />
                        </Grid>
                        <Grid item xs={12}>
                            <TextField
                                className={`password`}
                                autoComplete={"off"}
                                fullWidth
                                value={currentUser.password}
                                label="Contraseña"
                                name="Contraseña"
                                size="small"
                                variant="outlined"
                                onChange={(e) => setCurrentUser({
                                    ...currentUser,
                                    password: validateInputData(e, "password"),
                                })}
                                type={showPassword ? "text" : "password"}
                                InputProps={{ // <-- This is where the toggle button is added.
                                    endAdornment: (
                                        <InputAdornment position="end">
                                            <IconButton
                                                aria-label="toggle password visibility"
                                                onClick={handleClickShowPassword}
                                            >
                                                {showPassword ? <Visibility/> :
                                                    <VisibilityOff/>}
                                            </IconButton>
                                        </InputAdornment>
                                    )
                                }}
                            />
                        </Grid>
                    </Grid>
                    <Grid item xs={12}>
                        <Button
                            ref={buttonRef}
                            autoFocus={true}
                            color={"primary"}
                            fullWidth type="submit"
                            variant="contained"
                            // disabled={!currentUser.username || !currentUser.password}
                            onClick={handleLogIn}
                        >
                            ingresar
                        </Button>
                    </Grid>
                </Grid>
            </Container>
        </Grid>
    );
};
