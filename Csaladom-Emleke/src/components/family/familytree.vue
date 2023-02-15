<template>
    <div id="tree" ref="tree"></div>
</template>

<script>

    import FamilyTree from '@balkangraph/familytree.js'

    export default {
        name: 'tree',
        data(){
            return {
                family: {}
            }
        },
        methods: {
            mytree: function(domEl, x) {
                this.family = new FamilyTree (domEl, {
                    nodes: x,
                    nodeBinding: {
                        field_0: "teljesnev",
                        field_1: "szulido",
                        img_0: "img"
                    },
                    nodeTreeMenu: true,
                    editForm: {
                        titleBinding: "name",
                        photoBinding: "photo",
                        generateElementsFromFields: false,
                        addMore: false,
                        elements: [
                            [
                                {type: 'textbox', label: "Vezetéknév", binding: 'vezeteknev'},
                                {type: 'textbox', label: "Keresztnév", binding: 'keresztnev'}
                            ],
                            { type: 'textbox', label: "Telefonszám", binding: 'telefonszam'},
                            { type: 'textbox', label: "Neme", binding: 'nem'},
                            [
                                { type: 'date', label: "Születési dátum", binding: 'szulido'},
                                { type:'date', label: "Halálozási dátum", binding: 'halido'},
                            ],
                            { type: 'textbox', label: "Születési helye", binding: 'szulhely'},
                        ],
                        buttons: {
                            edit: {
                                icon: FamilyTree.icon.edit(24, 24, '#fff'),
                                text: 'Edit',
                                hideIfEditMode: true,
                                hideIfDetailsMode: false
                            },
                            share: null,
                            pdf: null,
                            remove: {
                                icon: FamilyTree.icon.remove(24, 24, '#fff'),
                                text: 'Törlés'
                            }
                        }
                    }
                });
            },
            Rajzol(){
                this.mytree(this.$refs.tree, this.$store.getters.Members);

                this.family.onUpdateNode((args) => {
                    //console.log(args.addNodesData);
                    console.log(args.updateNodesData);
                    console.log(this.$store.getters.Members);
                    //console.log(args.removeNodeId);

                    args.updateNodesData.forEach(item => {
                        item = this.Nev_Gender_Nem_Beallitas(item);
                        this.DB_Update(item);
                        
                    });
                });

                this.family.editUI.on('button-click', function (sender, args) {
                if (args.name == 'remove') {
                    //alert('Törlés')
                }
            });
            },
            DB_Update(){
                // Axios, adatbázis frissítés
            },
            Nev_Gender_Nem_Beallitas(item){
                item.teljesnev = item.vezeteknev + " " + item.keresztnev;
                if (item.nem != null) {
                    if (item.nem.toLowerCase() == "férfi") {
                        item.gender = "male";
                    } else if (item.nem.toLowerCase() == "nő") {
                        item.gender = "female";
                    }
                    else {
                        item.gender = item.nem;
                    }
                }
                if (item.gender == "male") {
                    item.nem = "Férfi";
                } else if (item.gender == "female") {
                    item.nem = "Nő"
                }
                return item;
            }
        },
    }
</script>