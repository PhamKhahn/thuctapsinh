# Config sendmail

```
  <global>
    <email_notification>yes</email_notification>
    <email_to>khanhpq.isec@gmail.com</email_to>
    <smtp_server>localhost</smtp_server>
    <email_from>pham.khanh.1.9.1996@gmail.com</email_from>
    <email_maxperhour>100</email_maxperhour>
  </global>


  <alerts>
    <log_alert_level>1</log_alert_level>
    <email_alert_level>7</email_alert_level>
  </alerts>


  <email_alerts>
    <email_to>khanh.96.alert.12@gmail.com</email_to>
    <level>12</level>
  </email_alerts>

  <email_alerts>
    <email_to>khanh.96.syscheck.ossec@gmail.com</email_to>
    <group>syscheck</group>
  </email_alerts>

```