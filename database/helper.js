import { initConnection } from ".";

async function queryDatabase(query, params) {
    const conn = await initConnection.getConnection();
    try {
        const [rows] = await conn.query(query, params);
        return rows;
    } catch (err) {
        console.error(err);
        throw err;
    } finally {
        conn.release();
    }
}

export async function createRecord(table, records) {
    const columns = Object.keys(records[0]).toString();
    const values = records.map((record) => [Object.values(record)]);
    const query = `INSERT INTO ${table} ${columns} VALUES ?`;
    return await queryDatabase(query, [values]);
}

export async function updateRecord(table, record, whereColumns) {
    const columns = Object.keys(record)
        .map((ele) => `${ele} = ?`)
        .toString();
    const whereClause = Object.keys(whereColumns)
        .map((key) => `${key} = ?`)
        .join(" AND ");
    const params = [...Object.values(record), ...Object.values(whereColumns)];
    const query = `UPDATE ${table} SET ${columns} WHERE ${whereClause}`;
    return await queryDatabase(query, params);
}

export async function getAllRecords(table) {
    const query = `SELECT * FROM ${table}`;
    return await queryDatabase(query);
}

export async function getRecordById(table, whereColumns) {
    const whereClause = Object.keys(whereColumns)
        .map((key) => `${key} = ?`)
        .join(" AND ");
    const query = `SELECT * FROM ${table} WHERE ${whereClause}`;
    return await queryDatabase(query, [...Object.values(whereColumns)]);
}

export async function deleteRecord(table, whereColumns) {
    const whereClause = Object.keys(whereColumns)
        .map((key) => `${key} = ?`)
        .join(" AND ");
    const query = `DELETE FROM ${table} WHERE ${whereClause}`;
    return await queryDatabase(query, [...Object.values(whereColumns)]);
}
