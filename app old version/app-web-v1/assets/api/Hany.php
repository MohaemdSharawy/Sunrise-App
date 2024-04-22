<?php

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
class Hany extends REST_Controller {

    function __construct()
    {
        // Construct the parent class
        parent::__construct();
    }

    public function data_get()
    {
        $this->load->library('form_validation');
        if ($this->form_validation->run() == FALSE)
        {
            // form validation error
            $message = array(
                'status' => FALSE,
                'error' => $this->form_validation->error_array(),
                'message' => validation_errors() 
            );
            $this->response($message, REST_Controller::HTTP_NOT_FOUND);
        }
        else 
        {
            // success
            $message = array(
                'status' => TRUE,
                'message' => 'API PR Add Successful.'
            );
            $this->response($message, REST_Controller::HTTP_OK);
        }
    }

    public function data_post()
    {
        $this->load->library('form_validation');
        if ($this->form_validation->run() == FALSE)
        {
            // form validation error
            $message = array(
                'status' => FALSE,
                'error' => $this->form_validation->error_array(),
                'message' => validation_errors() 
            );
            $this->response($message, REST_Controller::HTTP_NOT_FOUND);
        }
        else 
        {
            // success
            $message = array(
                'status' => TRUE,
                'message' => 'API PR Add Successful.'
            );
            $this->response($message, REST_Controller::HTTP_OK);
        }
    }
}
