import React, {useEffect, useRef, useState} from 'react';
import Button from '@material-ui/core/Button';
import Grid from '@material-ui/core/Grid';
import TextField from '@material-ui/core/TextField';
import Container from "@material-ui/core/Container";
import useStyles from "./styles";
import Typography from "@mui/material/Typography";
import ICourseCreateReqDto
    from "@usecases/course/create/ICourseCreateReqDto";
import CursoService from "@services/CursoService";

export default function CourseAddForm(props: { title: string }) {
    const courseAddService = new CursoService();

    const buttonRef = useRef<HTMLButtonElement>(null);
    const classes = useStyles();
    const emptyApplicant: ICourseCreateReqDto = {
        comision: "",
        CodAula: 0,
        CodDocente: 0,
        CodNivel: 0,
    };
    const [newCourse, setNewCourse] = useState<ICourseCreateReqDto>(emptyApplicant);

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

    const cleanInputValues = () => {
        setNewCourse(emptyApplicant);
    }

    const saveApplicant = async () => {
        let message;
        if (
            !newCourse.CodNivel ||
            !newCourse.comision
        ) {
            message = "Por favor complete los campos requeridos";
            alert(message);
            return;
        }
        const newCoursePost: ICourseCreateReqDto = {
            comision: newCourse.comision,
            CodAula: newCourse.CodAula,
            CodDocente: newCourse.CodDocente,
            CodNivel: newCourse.CodNivel,
        };

        courseAddService
            .create(newCoursePost as ICourseCreateReqDto)
            .then(createdCourse => {
                alert(`El curso para "${createdCourse.CodNivel}" se persistió correctamente`);
                cleanInputValues();
            })
            .catch(err => {
                err.then((err: Error) => {
                        console.error("ERROR en FE", err.message);
                        alert(`${err.message}`);
                    }
                )
            });
    };

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
                {/*<h1 className={classes.CodNivel}>{props?.title || "Alta de registro"}</h1>*/}
            </Grid>

            <Container className={classes.root} maxWidth="xs">
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        {/*nivel*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`CodNivel`}
                                style={{background: newCourse.CodNivel ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                value={newCourse?.CodNivel > 0 ? newCourse?.CodNivel : ""}
                                error={!newCourse?.CodNivel}
                                type="number"
                                InputProps={{ inputProps: { min: 1, max: 5 } }}
                                onChange={(e) => {
                                    setNewCourse({
                                        ...newCourse,
                                        CodNivel: parseInt(e.target.value),
                                    });
                                }}
                                label="Nivel"
                                name="CodNivel"
                                size="small"
                                variant="outlined"
                            />
                        </Grid>

                        {/*comisión*/}
                        <Grid item xs={12}>
                            <TextField
                                className={`comision`}
                                style={{background: newCourse.comision ? '#e8ffe9' : 'inherit'}}
                                autoComplete={"off"}
                                fullWidth
                                disabled={!newCourse.CodNivel}
                                value={!!newCourse?.CodNivel && newCourse?.comision || ""}
                                error={!!newCourse?.CodNivel && !newCourse?.comision}

                                onChange={(e) => {
                                    setNewCourse({
                                        ...newCourse,
                                        comision: e.target.value,
                                    });
                                }}
                                label="Comisión"
                                type="text"
                                name="comision"
                                size="small"
                                variant="outlined"
                                multiline
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
                            disabled={
                                !newCourse.CodNivel ||
                                !newCourse.comision
                            }
                            onClick={saveApplicant}
                        >
                            crear
                        </Button>
                    </Grid>
                </Grid>
            </Container>
        </Grid>
    );
};
