<?php

defined('BASEPATH') OR exit('No direct script access allowed');
require __DIR__.'/REST_Controller.php';

class Employee extends REST_Controller {

    function __construct()
    {
        parent::__construct();
    }


    public function data_put()
    {
        $update_data = json_decode(file_get_contents('php://input'), true);

        if(empty($update_data))
        {
            $message = array(
            'status' => FALSE,
            'message' => 'No Employee Data'
            );
            $this->response($message, REST_Controller::HTTP_NOT_FOUND);
        
        } else {
            $total_imported = 0;
            $total_updated  = 0;

            foreach ($update_data as $employee) {
                if (isset($employee['EMP_CODE']) && $employee['EMP_CODE'] != '') {
                    $this->db->insert('api_employee', $employee);
                    $total_imported++;
                }
            }

            if($update_data > 0 && !empty($update_data)){
                // success
                $message = array(
                'status' => TRUE,
                'message' => 'Total Employee imported-updated [' . $total_imported . ' - '. $total_updated .']'
                );
                $this->response($message, REST_Controller::HTTP_OK);
            
            }else{
                // error
                $message = array(
                'status' => FALSE,
                'message' => 'API Employee Update Fail.'
                );
                $this->response($message, REST_Controller::HTTP_NOT_FOUND);
            }
        }
    }
}
