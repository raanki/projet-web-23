<script setup>
import AnalyticsCongratulations from '@/views/dashboard/AnalyticsCongratulations.vue'
import AnalyticsFinanceTabs from '@/views/dashboard/AnalyticsFinanceTab.vue'
import AnalyticsOrderStatistics from '@/views/dashboard/AnalyticsOrderStatistics.vue'
import AnalyticsProfitReport from '@/views/dashboard/AnalyticsProfitReport.vue'
import AnalyticsTotalRevenue from '@/views/dashboard/AnalyticsTotalRevenue.vue'
import AnalyticsTransactions from '@/views/dashboard/AnalyticsTransactions.vue'

// 👉 Images
import chart from '@images/cards/chart-success.png'
import card from '@images/cards/credit-card-primary.png'
import paypal from '@images/cards/paypal-error.png'
import student from '@images/cards/school.png'
import late from '@images/cards/late.png'
import week_loans from '@images/cards/7-days.png'
import wallet from '@images/cards/wallet-info.png'
</script>

<template>
  <VRow>
    <!-- 👉 Congratulations -->
    <VCol
      cols="12"
    >
      <AnalyticsCongratulations />
    </VCol>

    <VCol
      cols="12"
      sm="8"
      md="4"
      order="1"
      order-md="2"
    >
      <VRow>
        <!-- 👉 Student -->
        <VCol
          cols="12"
          sm="6"
        >
          <CardStatisticsVertical
            v-bind=" {
              title: 'Student',
              image: student,
              stats: '25',
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Late Loans -->
        <VCol
          cols="12"
          sm="6"
        >
          <CardStatisticsVertical
            v-bind="{
              title: 'Late Loans',
              image: late,
              stats: '2',
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Total Equipement -->
        <VCol
          cols="12"
          sm="6"
        >
          <CardStatisticsVertical
            v-bind="{
              title: 'Total Equipement',
              image: chart,
              stats: '7',
              change:  null,
            }"
          />
        </VCol>

        <!-- 👉 Loan Weekly -->
        <VCol
          cols="12"
          sm="6"
        >
          <CardStatisticsVertical
            v-bind="{
              title: 'Week\'s Loans',
              image: week_loans,
              stats: '3',
              change: null,
            }"
          />
        </VCol>
      </VRow>

    </VCol>

    <!-- 👉 Latest Equipement loans -->
    <VCol
      cols="12"
      md="4"
      sm="6"
      order="3"
    >
      <AnalyticsTransactions />
    </VCol>

    <!-- 👉 Loan Statistics -->
    <VCol
      cols="12"
      md="4"
      sm="6"
      order="3"
    >
      <AnalyticsOrderStatistics />
    </VCol>



<!--    &lt;!&ndash; 👉 Tabs chart &ndash;&gt;-->
<!--    <VCol-->
<!--      cols="12"-->
<!--      md="4"-->
<!--      sm="6"-->
<!--      order="3"-->
<!--    >-->
<!--      <AnalyticsFinanceTabs />-->
<!--    </VCol>-->

  </VRow>
</template>
