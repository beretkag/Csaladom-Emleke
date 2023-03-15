import { def } from '@vue/shared';
import { createStore } from 'vuex';
import moment from "moment";


    const store = createStore({
        state: {
            baseURL: "http://localhost:3000",
            members: [
                { id: 1, pids: [2], name: "Amber McKenzie", gender: "female", img: "https://cdn.balkan.app/shared/2.jpg"  },
                { id: 2, pids: [1], name: "Ava Field", gender: "male", img: "https://cdn.balkan.app/shared/m30/5.jpg" },
                { id: 3, mid: 1, fid: 2, name: "Peter Stevens", gender: "male", img: "https://cdn.balkan.app/shared/m10/2.jpg" },
                { id: 4, mid: 1, fid: 2, name: "Savin Stevens", gender: "male", img: "https://cdn.balkan.app/shared/m10/1.jpg"  },
                { id: 5, mid: 1, fid: 2, name: "Emma Stevens", gender: "female", img: "https://cdn.balkan.app/shared/w10/3.jpg" }
            ],
            alertMsg:{
                message: "",
                visible: false,
                style: "danger"
            },
            csaldfaID:"",
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
            }
        }
    })

    export default store;