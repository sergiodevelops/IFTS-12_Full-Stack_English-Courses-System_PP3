import { makeStyles } from '@material-ui/core/styles';

export default makeStyles(() => ({
    root:{
        padding: "1.2rem"
    },
    queryTable:{
        textAlign: 'center',
    },
    headerTableRow:{
        background: '#dee6ff',

        fontSize: "14px",
        fontWeight: 'bold',
    },
    valuesTableRow:{
        minHeight: '6%',
        cursor:'pointer',
        '&:hover':{
            outline: '-webkit-focus-ring-color auto 1px',
            background: 'rgba(188,255,233,0.39)',
        },
    },
    tableCell:{
        display:'flex',
        justifyContent:'center',
        alignItems:'start',
        wordBreak: "break-word",
        borderWidth: "1px",
        borderStyle: "solid",
        padding: "5px",
        borderColor: "#a8b1ff",
    },
    arrowChangeQueryPage:{
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: '#2a77d20d',
        cursor: 'pointer',
    },
    containerMsgQueryResults:{
        display:'flex',
        alignItems:'center',
        justifyContent:'center',
    },
    msgQueryResults:{
        color: '#ff000073',
    },
}));
