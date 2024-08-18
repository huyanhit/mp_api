<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | The following language lines contain the default error messages used by
    | the validator class. Some of these rules have multiple versions such
    | as the size rules. Feel free to tweak each of these messages here.
    |
    */

    'accepted' => 'accepted#The :attribute must be accepted.',
    'accepted_if' => 'accepted_if#The :attribute must be accepted when :other is :value.',
    'active_url' => 'active_url#The :attribute is not a valid URL.',
    'after' => 'after#The :attribute must be a date after :date.',
    'after_or_equal' => 'after_or_equal#The :attribute must be a date after or equal to :date.',
    'alpha' => 'alpha#The :attribute must only contain letters.',
    'alpha_dash' => 'alpha_dash#The :attribute must only contain letters, numbers, dashes and underscores.',
    'alpha_num' => 'alpha_num#The :attribute must only contain letters and numbers.',
    'array' => 'array#The :attribute must be an array.',
    'before' => 'before#The :attribute must be a date before :date.',
    'before_or_equal' => 'before_or_equal#The :attribute must be a date before or equal to :date.',
    'between' => [
        'numeric' => 'The :attribute must be between :min and :max.',
        'file' => 'The :attribute must be between :min and :max kilobytes.',
        'string' => 'The :attribute must be between :min and :max characters.',
        'array' => 'The :attribute must have between :min and :max items.',
    ],
    'boolean' => 'The :attribute field must be true or false.',
    'confirmed' => 'The :attribute confirmation does not match.',
    'current_password' => 'The password is incorrect.',
    'date' => 'The :attribute is not a valid date.',
    'date_equals' => 'The :attribute must be a date equal to :date.',
    'date_format' => 'The :attribute does not match the format :format.',
    'declined' => 'The :attribute must be declined.',
    'declined_if' => 'The :attribute must be declined when :other is :value.',
    'different' => 'The :attribute and :other must be different.',
    'digits' => 'The :attribute must be :digits digits.',
    'digits_between' => 'The :attribute must be between :min and :max digits.',
    'dimensions' => 'The :attribute has invalid image dimensions.',
    'distinct' => 'The :attribute field has a duplicate value.',
    'email' => 'The :attribute must be a valid email address.',
    'ends_with' => 'The :attribute must end with one of the following: :values.',
    'enum' => 'The selected :attribute is invalid.',
    'exists' => 'The selected :attribute is invalid.',
    'file' => 'The :attribute must be a file.',
    'filled' => 'The :attribute field must have a value.',
    'gt' => [
        'numeric' => 'gt_numeric#The :attribute must be greater than :value.',
        'file' => 'gt_file#The :attribute must be greater than :value kilobytes.',
        'string' => 'gt_string#The :attribute must be greater than :value characters.',
        'array' => 'gt_array#The :attribute must have more than :value items.',
    ],
    'gte' => [
        'numeric' => 'gte_numeric#The :attribute must be greater than or equal to :value.',
        'file' => 'gte_file#The :attribute must be greater than or equal to :value kilobytes.',
        'string' => 'gte_string#The :attribute must be greater than or equal to :value characters.',
        'array' => 'gte_array#The :attribute must have :value items or more.',
    ],
    'image' => 'image#The :attribute must be an image.',
    'in' => 'in#The selected :attribute is invalid.',
    'in_array' => 'in_array#The :attribute field does not exist in :other.',
    'integer' => 'integer#The :attribute must be an integer.',
    'ip' => 'ip#The :attribute must be a valid IP address.',
    'ipv4' => 'ipv4#The :attribute must be a valid IPv4 address.',
    'ipv6' => 'ipv6#The :attribute must be a valid IPv6 address.',
    'json' => 'json#The :attribute must be a valid JSON string.',
    'lt' => [
        'numeric' => 'lt_numeric#The :attribute must be less than :value.',
        'file' => 'lt_file#The :attribute must be less than :value kilobytes.',
        'string' => 'lt_string#The :attribute must be less than :value characters.',
        'array' => 'lt_array#The :attribute must have less than :value items.',
    ],
    'lte' => [
        'numeric' => 'lte_numeric#The :attribute must be less than or equal to :value.',
        'file' => 'lte_file#The :attribute must be less than or equal to :value kilobytes.',
        'string' => 'lte_string#The :attribute must be less than or equal to :value characters.',
        'array' => 'lte_array#The :attribute must not have more than :value items.',
    ],
    'mac_address' => 'mac_address#The :attribute must be a valid MAC address.',
    'max' => [
        'numeric' => 'max_numeric#The :attribute must not be greater than :max.',
        'file' => 'max_file#The :attribute must not be greater than :max kilobytes.',
        'string' => 'max_string#The :attribute must not be greater than :max characters.',
        'array' => 'max_array#The :attribute must not have more than :max items.',
    ],
    'mimes' => 'mimes#The :attribute must be a file of type: :values.',
    'mimetypes' => 'mimetypes#The :attribute must be a file of type: :values.',
    'min' => [
        'numeric' => 'min_numeric#The :attribute must be at least :min.',
        'file' => 'min_file#The :attribute must be at least :min kilobytes.',
        'string' => 'min_string#The :attribute must be at least :min characters.',
        'array' => 'min_array#The :attribute must have at least :min items.',
    ],
    'multiple_of' => 'multiple_of#The :attribute must be a multiple of :value.',
    'not_in' => 'not_in#The selected :attribute is invalid.',
    'not_regex' => 'not_regex#The :attribute format is invalid.',
    'numeric' => 'numeric#The :attribute must be a number.',
    'password' => 'password#The password is incorrect.',
    'present' => 'present#The :attribute field must be present.',
    'prohibited' => 'prohibited#The :attribute field is prohibited.',
    'prohibited_if' => 'prohibited_if#The :attribute field is prohibited when :other is :value.',
    'prohibited_unless' => 'prohibited_unless#The :attribute field is prohibited unless :other is in :values.',
    'prohibits' => 'prohibits#The :attribute field prohibits :other from being present.',
    'regex' => 'regex#The :attribute format is invalid.',
    'required' => 'required#The :attribute field is required.',
    'required_array_keys' => 'required_array_keys#The :attribute field must contain entries for: :values.',
    'required_if' => 'required_if#The :attribute field is required when :other is :value.',
    'required_unless' => 'required_unless#The :attribute field is required unless :other is in :values.',
    'required_with' => 'required_with#The :attribute field is required when :values is present.',
    'required_with_all' => 'required_with_all#The :attribute field is required when :values are present.',
    'required_without' => 'required_without#The :attribute field is required when :values is not present.',
    'required_without_all' => 'required_without_all#The :attribute field is required when none of :values are present.',
    'same' => 'same#The :attribute and :other must match.',
    'size' => [
        'numeric' => 'size_numeric#The :attribute must be :size.',
        'file' => 'size_file#The :attribute must be :size kilobytes.',
        'string' => 'size_string#The :attribute must be :size characters.',
        'array' => 'size_array#The :attribute must contain :size items.',
    ],
    'starts_with' => 'starts_with#The :attribute must start with one of the following: :values.',
    'string' => 'string#The :attribute must be a string.',
    'timezone' => 'timezone#The :attribute must be a valid timezone.',
    'unique' => 'unique#The :attribute has already been taken.',
    'uploaded' => 'uploaded#The :attribute failed to upload.',
    'url' => 'url#The :attribute must be a valid URL.',
    'uuid' => 'uuid#The :attribute must be a valid UUID.',

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | Here you may specify custom validation messages for attributes using the
    | convention "attribute.rule" to name the lines. This makes it quick to
    | specify a specific custom language line for a given attribute rule.
    |
    */

    'custom' => [
        'attribute-name' => [
            'rule-name' => 'custom-message',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Attributes
    |--------------------------------------------------------------------------
    |
    | The following language lines are used to swap our attribute placeholder
    | with something more reader friendly such as "E-Mail Address" instead
    | of "email". This simply helps us make our message more expressive.
    |
    */

    'attributes' => [],

];
