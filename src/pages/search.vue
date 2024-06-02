<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { API_URL } from '@/env'

const route = useRoute()
const searchResults = ref([])
const searchTerm = ref(route.params.search || '')

const fetchSearchResults = async (term) => {
  try {
    const response = await fetch(`${API_URL}api/search?search=${term}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
      },
    })
    if (!response.ok) {
      throw new Error('Network response was not ok')
    }
    const data = await response.json()
    searchResults.value = data
  } catch (error) {
    console.error('Error fetching data:', error)
  }
}

onMounted(() => {
  if (searchTerm.value) {
    fetchSearchResults(searchTerm.value)
  }
})

watch(route, (newRoute) => {
  searchTerm.value = newRoute.params.search
  if (searchTerm.value) {
    fetchSearchResults(searchTerm.value)
  }
})
</script>

<template>
  <div>
    <h3>Search Results for "{{ searchTerm }}"</h3>
    <VTable>
      <thead>
      <tr>
        <th>Table Name</th>
        <th>Data</th>
      </tr>
      </thead>
      <tbody>
      <tr v-for="result in searchResults" :key="result.id">
        <td>{{ result.table_name }}</td>
        <td>{{ JSON.stringify(result) }}</td>
      </tr>
      </tbody>
    </VTable>
  </div>
</template>

<style scoped>
th {
  text-align: start !important;
  font-weight: bold !important;
}
</style>
