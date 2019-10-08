<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Intouch\Newrelic\Newrelic;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        $nr = new Newrelic();
        $nr->setAppName('MyApp');
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
