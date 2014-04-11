class CreateSubDepartmentExtensionRangeViews < ActiveRecord::Migration
  def change
      execute("CREATE VIEW `sub_department_extension_range_view` AS
SELECT `sd1`.`id`                                        AS `sub_department_id`,
        `sd1`.`name`                                     AS `sub_department`,
        `d1`.`id`                                        AS `department_id`,
        `d1`.`name`                                      AS `department`,
        IFNULL(sd1.preferred_extension_range_id, er1.id) AS extension_range_id,
        `er1`.`first_extension`                          AS `first_extension`,
        `er1`.`last_extension`                           AS `last_extension`
  FROM `sub_departments` `sd1` 
        INNER JOIN `departments` `d1`
           ON `sd1`.`department_id` = `d1`.`id`
        INNER JOIN `departments_extension_ranges` `der1`
           ON `d1`.`id` = `der1`.`department_id`
        INNER JOIN  `extension_ranges` `er1`
           ON `der1`.`extension_range_id` = `er1`.`id`")
  end
end
