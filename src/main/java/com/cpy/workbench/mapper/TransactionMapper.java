package com.cpy.workbench.mapper;

import com.cpy.workbench.domain.Transaction;

public interface TransactionMapper {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Wed Jul 20 15:45:25 CST 2022
     */
    int deleteByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Wed Jul 20 15:45:25 CST 2022
     */
    int insert(Transaction record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Wed Jul 20 15:45:25 CST 2022
     */
    int insertSelective(Transaction record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Wed Jul 20 15:45:25 CST 2022
     */
    Transaction selectByPrimaryKey(String id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Wed Jul 20 15:45:25 CST 2022
     */
    int updateByPrimaryKeySelective(Transaction record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table tbl_tran
     *
     * @mbggenerated Wed Jul 20 15:45:25 CST 2022
     */
    int updateByPrimaryKey(Transaction record);
}