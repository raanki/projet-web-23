<template>
  <VCard :title="props.title">
    <VTable>
      <thead>
      <tr>
        <th v-for="field in props.fields" :key="field.key">
          {{ field.label }}
        </th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="item in props.items" :key="item.name">
        <td v-for="field in props.fields" :key="field.key">
          {{ field.formatter ? field.formatter(item[field.key]) : item[field.key] }}
        </td>
        <td class="actions d-flex justify-content-between align-items-center">
          <router-link :to="`/${props.type}/see/${item.id}`" class="action see"><i class="fa-solid fa-eye"></i></router-link>
          <router-link :to="`/${props.type}/edit/${item.id}`" class="action edit"><i class="fa-solid fa-pen-to-square"></i></router-link>
          <a href="#" class="action delete" @click.prevent="confirmDelete(item)"><i class="fa-solid fa-trash"></i></a>
        </td>
      </tr>
      </tbody>
    </VTable>
    <v-dialog v-model="dialogDelete" max-width="500px">
      <v-card>
        <v-card-title class="headline">Confirmation</v-card-title>
        <v-card-text>
          Êtes-vous sûr de vouloir supprimer cet élément ?
        </v-card-text>
        <v-card-actions>
          <v-btn color="red darken-1" text @click="dialogDelete = false">Annuler</v-btn>
          <v-btn color="green darken-1" text @click="deleteItem">Confirmer</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </VCard>
</template>

<script setup>
import { defineProps, ref } from 'vue'

const props = defineProps({
  items: Array,
  fields: Array,
  title: String,
  type: String,
})

const dialogDelete = ref(false);
let currentItemToDelete = null;

function confirmDelete(item) {
  currentItemToDelete = item;
  dialogDelete.value = true;
}

function deleteItem() {
  console.log("Item supprimé :", currentItemToDelete);
  dialogDelete.value = false;
}
</script>

<style scoped>
th {
  text-align: start !important;
  font-weight: bold !important;
}
.action {
  margin-right: 10px !important;
  margin-top: 10px !important;
}
</style>
