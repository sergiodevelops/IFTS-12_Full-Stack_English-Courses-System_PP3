import useStyles from "@components/pages/Login/styles";
import Container from "@material-ui/core/Container";
import Grid from "@material-ui/core/Grid";
import Button from "@material-ui/core/Button";
import React from "react";

export function ActionButton(props: { authMode: boolean }) {
    const classes = useStyles();
    const {authMode} = props;

    return (
        <Container className={classes.container} maxWidth="xs">
            <Grid container spacing={3}>
                <Grid hidden item xs={12}>
                    <Button
                        style={{background: '#dd4895'}}
                        color="secondary"
                        fullWidth
                        type="submit"
                        variant="contained"
                    >
                        {authMode ? "crear nueva cuenta" : "volver"}
                    </Button>
                </Grid>
            </Grid>
        </Container>
    );
}