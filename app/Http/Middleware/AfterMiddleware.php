<?php

namespace App\Http\Middleware;

use Closure;
use Intouch\Newrelic\Newrelic;

class AfterMiddleware
{
    public function handle($request, Closure $next)
    {
        $response = $next($request);
        $nr = new Newrelic();
        $nr->setAppName('MyApp');

        return $response;
    }
}
