import { def } from '@vue/shared';
import { createStore } from 'vuex';
import moment from "moment";


    const store = createStore({
        state: {
            baseURL: "http://localhost:3000",
            members: [],
            alertMsg:{
                message: "",
                visible: false,
                style: "danger"
            },
            csaldfaID:"",
            settings:{},
        },
        getters: {
            Members: state => {
                return state.members;
            },
            baseURL: state => {
                return state.baseURL;
            },
            alertMsg: state => {
                return state.alertMsg;
            },
            CsaladfaID: state =>{
                return state.csaldfaID;
            },
            Settings: state => {
                return state.settings;
            }
        },
        mutations:{
            SetMembers: (state, payload) => {
                payload.forEach(item => {
                    item.id = item.belsofaID;
                    item.szulido = item.szulido == null ? null : moment(item.szulido).format('YYYY-MM-DD');
                    item.halido = item.halido == null ? null : moment(item.halido).format('YYYY-MM-DD');
                    item.nem = item.gender == "male" ? "Férfi" : item.nem;
                    item.nem = item.gender == "female" ? "Nő" : item.nem;
                    item.pids = item.partnerek == null ? null : item.partnerek.split(",");
                    item.vezeteknev = item.vezeteknev == null ? "" : item.vezeteknev;
                    item.keresztnev = item.keresztnev == null ? "" : item.keresztnev;
                    item.teljesnev = item.vezeteknev + " " + item.keresztnev;
                    item.profilkep = item.profilkep != null ? state.baseURL + '/img/' + item.profilkep : null;
                });
                state.members =  payload
            },
            SetUser: (state, payload) => {
                state.loggedUser = payload;
            },
            DeleteNode: (state, nodeId) => {
                state.members.splice(state.members.findIndex(x => x.ID == nodeId), 1)
            },
            UpdateNode: (state, node) => {
                state.members[state.members.findIndex(x => x.ID == node.ID)] = node
            },
            ShowMsg: (state, payload) => {
                state.alertMsg.message = payload.text;
                state.alertMsg.visible = true;
                state.alertMsg.style = payload.type;
            },
            HideMsg: state =>{
                state.alertMsg.visible = false;
            },
            SetCsaladfaID: (state, csaldfaID) => {
                state.csaldfaID = csaldfaID;
            },
            LoadSettings: (state, payload) => {
                state.settings = {
                    ID: payload.ID,
                    csaladfaID: payload.csaladfaID,
                    publikus: payload.publikus == 1 ? true :false,
                    darkmode: payload.darkmode == 1 ? true :false,
                    noszin: payload.noszin,
                    ferfiszin: payload.ferfiszin,
                    Nev: payload.Nev
                }
            }
        }
    })

    export default store;