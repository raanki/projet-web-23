<script setup>
import { ref, onMounted, watch } from 'vue'
import { useRoute } from 'vue-router'
import { API_URL } from '@/env'
import dayjs from 'dayjs'

const route = useRoute()
const searchResults = ref([])
const searchTerm = ref(route.params.search || '')

const capitalize = (str) => {
  if (typeof str !== 'string') return ''
  return str.charAt(0).toUpperCase() + str.slice(1).toLowerCase()
}

const formatLabel = (key) => {
  return key.replace(/_/g, ' ').split(' ').map(word => capitalize(word)).join(' ')
}

const formatDate = (dateStr) => {
  return dayjs(dateStr).format('DD/MM/YYYY')
}

const formatField = (key, value) => {
  if (value === 1 || value === 0) {
    return value === 1 ? 'Yes' : 'No'
  }
  if (key.slice(-4) === 'date') {
    return formatDate(value)
  }
  if (typeof value === 'string') {
    return capitalize(value)
  }
  return value
}

const transformResult = (result) => {
  const transformed = []
  Object.keys(result).forEach(key => {
    if (key !== 'table_name' && key !== 'barcode' && key !== 'password' && key !== 'image_id' && key !== 'barcode' && key !== 'barcode' ) {
      transformed.push(`<span class="label" style="font-weight: bold">${formatLabel(key)}:</span> ${formatField(key, result[key])}`)
    }
  })
  return transformed.join(', ')
}

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
      <tr v-for="(result, index) in searchResults" :key="index">
        <td style="font-weight: bold">{{ result.table_name }}</td>
        <td v-html="transformResult(result)"></td>
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

.label {
  font-weight: bold;
}
</style>
