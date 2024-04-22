<?php

// use Stripe\Error\Api;

defined('BASEPATH') OR exit('No direct script access allowed');

// This can be removed if you use __autoload() in config.php OR use Modular Extensions
/** @noinspection PhpIncludeInspection */
require __DIR__.'/REST_Controller.php';
/**
 * This is an example of a few basic user interaction methods you could use
 * all done with a hardcoded array
 *
 * @package         CodeIgniter
 * @subpackage      Rest Server
 * @category        Controller
 * @author          Phil Sturgeon, Chris Kacerguis
 * @license         MIT
 * @link            https://github.com/chriskacerguis/codeigniter-restserver
 */
class Advance_salary extends REST_Controller {

    function __construct()
    {
        // Construct the parent class
        parent::__construct();
        $this->load->model('hr/Advance_salary_model');
    }

    public function data_get($id)
    {
        $data = $this->Api_model->get_tabel('advance_salary',$id);
        if($data){
            $this->response($data, REST_Controller::HTTP_OK);
        }else{
            $this->response([
                'status' => FALSE,
                'message' => 'No data were found'
            ], REST_Controller::HTTP_NOT_FOUND); 
        }
    }

    public function data_post(){
        $fdata = [
            'group_id' => $this->Api_model->value($this->input->post('group_id', TRUE)),
            'supp_name' => $this->Api_model->value($this->input->post('supp_name', TRUE)),
            'interface' => $this->Api_model->value($this->input->post('interface', TRUE)),
            'phone' => $this->Api_model->value($this->input->post('phone', TRUE)),
            'address' => $this->Api_model->value($this->input->post('address', TRUE)),
            'contact' => $this->Api_model->value($this->input->post('contact', TRUE)),
            'cont_email' => $this->Api_model->value($this->input->post('cont_email', TRUE)),
            'rank' => $this->Api_model->value($this->input->post('rank', TRUE)),
            'deleted' => $this->Api_model->value($this->input->post('deleted', TRUE)),
        ];


         $check = $this->suppliers_model->get_supplier_by_code($fdata['interface']);
         if($check < 1){
             $result =  $this->db->insert('suppliers', $fdata);
         }
        
        if(isset($result) &&$result > 0 && !empty($result)){
            // success
            $message = array(
            'status' => TRUE,
            'message' => 'API PR Add Successful.'
            );
            $this->response($result, REST_Controller::HTTP_OK);
        }else{
            $message = array(
            'status' => FALSE,
            'message' => 'API PR Add Fail.'
            );
            $this->response($message, REST_Controller::HTTP_NOT_FOUND);
        }
    }
}
