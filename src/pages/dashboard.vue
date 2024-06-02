<script setup>
import { ref, onMounted } from 'vue'

// Importer les composants
import AnalyticsCongratulations from '@/views/dashboard/AnalyticsCongratulations.vue'
import AnalyticsOrderStatistics from '@/views/dashboard/AnalyticsOrderStatistics.vue'
import AnalyticsTransactions from '@/views/dashboard/AnalyticsTransactions.vue'

// Images
import chart from '@images/cards/chart-success.png'
import student from '@images/cards/school.png'
import late from '@images/cards/late.png'
import week_loans from '@images/cards/7-days.png'
import { API_URL } from '/src/env'

// Définir les références pour stocker les données
const numberOfStudents = ref(0)
const lateLoans = ref(0)
const totalEquipment = ref(0)
const weekLoans = ref(0)
const latestEquipmentLoans = ref([])
const popularEquipmentLoans = ref([])

// Fonction pour récupérer les données du backend
const fetchData = async () => {
  try {
    const response = await fetch(API_URL + 'api/dashboard')
    const data = await response.json()

    numberOfStudents.value = data.numberOfStudents
    lateLoans.value = data.lateLoans
    totalEquipment.value = data.totalEquipment
    weekLoans.value = data.weekLoans.length
    latestEquipmentLoans.value = data.latestEquipmentLoans
    popularEquipmentLoans.value = data.popularEquipmentLoans
  } catch (error) {
    console.error('Error fetching data:', error)
  }
}

// Appeler fetchData lors du montage du composant
onMounted(() => {
  fetchData()
})
</script>

<template>
  <VRow>
    <!-- 👉 Congratulations -->
    <VCol cols="12">
      <AnalyticsCongratulations/>
    </VCol>

    <VCol cols="12" sm="8" md="4" order="1" order-md="2">
      <VRow>
        <!-- 👉 Student -->
        <VCol cols="12" sm="6">
          <CardStatisticsVertical
            v-bind="{
              title: 'Students',
              image: student,
              stats: numberOfStudents,
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Late Loans -->
        <VCol cols="12" sm="6">
          <CardStatisticsVertical
            v-bind="{
              title: 'Late Loans',
              image: late,
              stats: lateLoans,
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Total Equipment -->
        <VCol cols="12" sm="6">
          <CardStatisticsVertical
            v-bind="{
              title: 'Total Equipment',
              image: chart,
              stats: totalEquipment,
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Loan Weekly -->
        <VCol cols="12" sm="6">
          <CardStatisticsVertical
            v-bind="{
              title: 'Week\'s Loans',
              image: week_loans,
              stats: weekLoans,
              change: null,
            }"
          />
        </VCol>
      </VRow>
    </VCol>

    <!-- 👉 Latest Equipment loans -->
    <VCol cols="12" md="4" sm="6" order="3">
      <AnalyticsTransactions :transactions="latestEquipmentLoans"/>
    </VCol>

    <!-- 👉 Loan Statistics -->
    <VCol cols="12" md="4" sm="6" order="3">
      <AnalyticsOrderStatistics :loans="popularEquipmentLoans"/>
    </VCol>
  </VRow>
</template>
