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
import wallet from '@images/cards/wallet-info.png'
</script>

<template>
  <VRow>
    <!-- 👉 Congratulations -->
    <VCol
      cols="12"
      md="8"
    >
      <AnalyticsCongratulations />
    </VCol>

    <VCol
      cols="12"
      sm="4"
    >
      <VRow>
        <!-- 👉 Equipement -->
        <VCol
          cols="12"
          md="6"
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
          md="6"
        >
          <CardStatisticsVertical
            v-bind="{
              title: 'Week\'s Loans',
              image: wallet,
              stats: '3',
              change: null,
            }"
          />
        </VCol>
      </VRow>
    </VCol>

    <!-- 👉 Total Revenue -->
<!--    <VCol-->
<!--      cols="12"-->
<!--      md="8"-->
<!--      order="2"-->
<!--      order-md="1"-->
<!--    >-->
<!--      <AnalyticsTotalRevenue />-->
<!--    </VCol>-->

    <VCol
      cols="12"
      sm="8"
      md="4"
      order="1"
      order-md="2"
    >
      <VRow>
        <!-- 👉 Payments -->
        <VCol
          cols="12"
          sm="6"
        >
          <CardStatisticsVertical
            v-bind=" {
              title: 'Students',
              image: paypal,
              stats: '25',
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Revenue -->
        <VCol
          cols="12"
          sm="6"
        >
          <CardStatisticsVertical
            v-bind="{
              title: 'Late Loans',
              image: card,
              stats: '0',
              change: null,
            }"
          />
        </VCol>

        <!-- 👉 Latest Equipement loans -->
        <VCol
          cols="12"
        >
          <AnalyticsTransactions />
        </VCol>
      </VRow>

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

    <!-- 👉 Tabs chart -->
    <VCol
      cols="12"
      md="4"
      sm="6"
      order="3"
    >
      <AnalyticsFinanceTabs />
    </VCol>

  </VRow>
</template>
