<script setup>
import { defineProps } from 'vue';
import { text } from "@fortawesome/fontawesome-svg-core"

const props = defineProps({
  items: Array,
  fields: Array,
  title: String,
});

function formatPrice(value) {
  return `${value}€`;
}

</script>

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
          <a href="#" class="action see"><i class="fa-solid fa-eye"></i></a>
          <a href="#" class="action edit"><i class="fa-solid fa-pen-to-square"></i></a>
          <a href="#" class="action delete"><i class="fa-solid fa-trash"></i></a>
        </td>
      </tr>
      </tbody>
    </VTable>
  </VCard>
</template>

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
