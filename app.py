import streamlit as st
import pandas as pd
import pyodbc
import os
import plotly.express as px

# ------------------ CONFIG ------------------
st.set_page_config(layout="wide", page_title="Retail Dashboard")
st.title("📊 Retail Sales Dashboard")

SQL_FOLDER = "SQL/Analysis"

# ------------------ DB CONNECTION ------------------
@st.cache_resource
def get_connection():
    return pyodbc.connect(
        "DRIVER={SQL Server};"
        "SERVER=localhost\\SQLEXPRESS;"  # change if needed
        "DATABASE=MyProject1;"
        "Trusted_Connection=yes;"
    )

conn = get_connection()

# ------------------ READ SQL ------------------
def read_sql_file(path):
    with open(path, 'r') as file:
        return file.read()

# ------------------ LOAD FILES ------------------
files = sorted([f for f in os.listdir(SQL_FOLDER) if f.endswith(".sql")])

# ------------------ SIDEBAR ------------------
st.sidebar.title("📂 Analysis Menu")
selected_file = st.sidebar.selectbox("Choose Query", files)

# ------------------ EXECUTE QUERY ------------------
query = read_sql_file(os.path.join(SQL_FOLDER, selected_file))

st.subheader(f"📌 {selected_file.replace('.sql','').replace('_',' ').title()}")

try:
    df = pd.read_sql(query, conn)

    if df.empty:
        st.warning("No data found")
    else:
        # ------------------ KPI SECTION ------------------
        st.markdown("### 📊 Key Insights")

        col1, col2, col3 = st.columns(3)

        with col1:
            st.metric("Rows", df.shape[0])

        with col2:
            st.metric("Columns", df.shape[1])

        with col3:
            if df.select_dtypes(include='number').shape[1] > 0:
                st.metric("Total (Numeric)", int(df.select_dtypes(include='number').sum().sum()))
            else:
                st.metric("Total (Numeric)", "N/A")

        st.divider()

        # ------------------ TABLE ------------------
        st.markdown("### 📋 Data Table")
        st.dataframe(df, use_container_width=True)

        st.divider()

        # ------------------ CHART ------------------
        st.markdown("### 📈 Visualization")

        numeric_cols = df.select_dtypes(include='number').columns
        all_cols = df.columns

        if len(all_cols) >= 2:
            x_axis = st.selectbox("Select X-axis", all_cols)
            y_axis = st.selectbox("Select Y-axis", numeric_cols if len(numeric_cols) > 0 else all_cols)

            chart_type = st.radio("Chart Type", ["Bar", "Line", "Scatter"])

            if chart_type == "Bar":
                fig = px.bar(df, x=x_axis, y=y_axis)
            elif chart_type == "Line":
                fig = px.line(df, x=x_axis, y=y_axis)
            else:
                fig = px.scatter(df, x=x_axis, y=y_axis)

            st.plotly_chart(fig, use_container_width=True)

except Exception as e:
    st.error(f"Error in {selected_file}: {e}")