import { makeStyles } from '@material-ui/core/styles';

export default makeStyles(() => ({
    root:{},
    queryTable:{
        textAlign: 'center',
    },
    tableHeaderRow:{
        fontWeight: 'bold',
    },
    tableBodyRow:{
        minHeight: '6%',
        cursor:'pointer',
        '&:hover':{
            outline: '-webkit-focus-ring-color auto 1px',
            background: '#eef1ffc4',
        },
    },
    tableBodyCell:{
        display:'flex',
        justifyContent:'center',
        alignItems:'center',
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
