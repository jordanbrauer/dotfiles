<?php

declare(strict_types = 1);

static $autoloader;

$autoloader = sprintf('%s/vendor/autoload.php', getcwd());

if (is_file($autoloader)) {
    require_once $autoloader;
}

return [
    'prompt' => 'λ ',
];

